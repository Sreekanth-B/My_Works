# Created by Sreekanth_B

# Chat bot creation steps 1

# Speech to text bot creation using Google speech Interface
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

#loop to continue executing multiple commands
while True:
    print(myCommand())
 
