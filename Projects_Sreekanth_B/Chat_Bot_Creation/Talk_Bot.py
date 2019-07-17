# Created by Sreekanth_B

# Talk Bot :: responds for the inputs given through microphone using deeplearning and Data Analysis techniques 

# Input is taken through the microphone by user and compares with the data loaded 

# -*- coding: utf-8 -*-
"""
Created on Sat May 18 12:18:23 2019

@author: SrEEKanTH
"""
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

def assistant_1(command):
    data = pd.read_csv("G:/Some Projects/Jarvis/sample.csv") 
    sk=[]
    for i in range(0,len(data)):
        if data.INPUT[i] == command:
            sk.append(data.OUTPUT[i])
    '''
    def res(command):        
        for i in range(0,len(data)):
            if data.INPUT[i] == command:
                sk = data.OUTPUT[i]
                return sk
           
    if len(res(command))>1:
        talkToMe(res(command))
    else:
        talkToMe('Sorry i dont have a word buddy')
    ''' 
    if len(sk)>0:
        talkToMe(sk[0])
    else:
        talkToMe('I dont have any word')
                
        
talkToMe('I am ready for your command')

#loop to continue executing multiple commands
while True:
    assistant_1(myCommand())

#data = pd.read_csv("G:/Some Projects/Jarvis/sample.csv") 

#print(data.head(100))
