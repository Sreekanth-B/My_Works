"""
@author: SrEEKanTH
"""

from gtts import gTTS
import speech_recognition as sr
import os
import re
import webbrowser
import smtplib
import requests
from weather import Weather
import pandas as pd

def talkToMe(audio):
    "speaks audio passed as argument"

    print(audio)
    text_to_speech = gTTS(text=audio, lang='en')
    text_to_speech.save('audio.mp3')
    os.system('start audio.mp3')
    #webbrowser.open("audio.mp3")
    #webbrowser.close()
    #play(audio.mp3)
    #file = "audio.mp3"
    #os.system('mpg123 audio.mp3')


def myCommand():
    "listens for commands"

    r = sr.Recognizer()

    with sr.Microphone() as source:
        print('Ready...')
        r.pause_threshold = 1
        r.adjust_for_ambient_noise(source, duration=1)
        audio = r.listen(source)

    try:
        command = r.recognize_google(audio).lower()
        
        print('You said: ' + command + '\n')

    #loop back to continue to listen for commands if unrecognizable speech is received
    except sr.UnknownValueError:
        print('Your last command couldn\'t be heard')
        command = myCommand();

    return command


def assistant(command):
    "if statements for executing commands"

    if 'open reddit' in command:
        reg_ex = re.search('open reddit (.*)', command)
        url = 'https://www.reddit.com/'
        if reg_ex:
            subreddit = reg_ex.group(1)
            url = url + 'r/' + subreddit
        webbrowser.open(url)
        print('Done!')

    elif 'open google' in command:
        reg_ex = re.search('open google (.+)', command)
        if reg_ex:
            domain = reg_ex.group(1)
            url = 'https://www.google.com' + domain
            webbrowser.open(url)
            print('Done!')
        else:
            pass

    elif 'hi jarvis' in command:
        talkToMe('hey Sree how are you')
    elif 'ok puppy tell me a joke' in command:
        res = requests.get(
                'https://icanhazdadjoke.com/',
                headers={"Accept":"application/json"}
                )
        if res.status_code == requests.codes.ok:
            talkToMe(str(res.json()['joke']))
        else:
            talkToMe('oops!I ran out of jokes')

    elif 'tell me current weather in' in command:
        reg_ex = re.search('current weather in (.*)', command)
        if reg_ex:
            city = reg_ex.group(1)
            weather = Weather()
            location = weather.lookup_by_location(city)
            condition = location.condition()
            talkToMe('The Current weather in %s is %s The tempeture is %.1f degree' % (city, condition.text(), (int(condition.temp())-32)/1.8))

    elif 'weather forecast in' in command:
        reg_ex = re.search('weather forecast in (.*)', command)
        if reg_ex:
            city = reg_ex.group(1)
            weather = Weather()
            location = weather.lookup_by_location(city)
            forecasts = location.forecast()
            for i in range(0,3):
                talkToMe('On %s will it %s. The maximum temperture will be %.1f degree.'
                         'The lowest temperature will be %.1f degrees.' % (forecasts[i].date(), forecasts[i].text(), (int(forecasts[i].high())-32)/1.8, (int(forecasts[i].low())-32)/1.8))


    elif 'open email' in command:
        talkToMe('Who is the recipient?')
        recipient = myCommand()

        if 'srikanth' in recipient:
            talkToMe('What should I say?')
            content = myCommand()

            #init gmail SMTP
            mail = smtplib.SMTP('smtp.gmail.com', 587)

            #identify to server
            mail.ehlo()

            #encrypt session
            mail.starttls()

            #login
            mail.login('username', 'password')

            #send message
            mail.sendmail('sreekanthsri62@gmail.com', 'sreekanthsri1135@gmail.com', content)

            #end mail connection
            mail.close()

            talkToMe('Email sent.')    

        else:
            talkToMe('I don\'t know what you mean!')
    elif 'hi puppy how are you' in command:
        talkToMe('hi sree i  am good what about you')
    elif 'you are so cool' in command:
        talkToMe('you too dear')


talkToMe('I am ready for your command')

#loop to continue executing multiple commands
while True:
    assistant(myCommand())
