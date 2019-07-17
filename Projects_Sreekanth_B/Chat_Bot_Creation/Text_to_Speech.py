# Created by Sreekanth_B

# Chat Bot creation step 2

# Text to speech conversion 

print('''\
  _____ _____ ____            _____         _     _          ____                       _     
 |_   _|_   _/ ___|          |_   _|____  _| |_  | |_ ___   / ___| _ __   ___  ___  ___| |__  
   | |   | | \___ \   _____    | |/ _ \ \/ / __| | __/ _ \  \___ \| '_ \ / _ \/ _ \/ __| '_ \ 
   | |   | |  ___) | |_____|   | |  __/>  <| |_  | || (_) |  ___) | |_) |  __/  __/ (__| | | |
   |_|   |_| |____/            |_|\___/_/\_\\__|  \__\___/  |____/| .__/ \___|\___|\___|_| |_|
                                                                  |_|                         
 ''' + '\n'*2)


from gtts import gTTS
import speech_recognition as sr
import os
import re
import webbrowser
import smtplib
import requests
#from weather import Weather
import pandas as pd
import sys

def talkToMe(audio):
    "speaks audio passed as argument"
    print(audio)
    text_to_speech = gTTS(text=audio, lang='en')
    text_to_speech.save('audio.mp3')
    os.system('start audio.mp3')

def test_f():
    my_text = input(' Enter text-to-speech:\n > ')
    # The language changed by changing 'en' (PS: 'en' means English) search on [Language Codes according to ISO 639-1] file for more Languages and it's Abbreviation
    #tts = gTTS(text=my_text, lang='en', slow=False)
    #tts.save('converted-file.mp3') 
    talkToMe(my_text)
    
while True :
    test_f()
