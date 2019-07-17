# Created by Sreekanth_B

# creating a chat bot which is useful for continuous chating and replaying based on the questions asked 

# Useful for repalcing manual work to respond for customer query.

"""
@author: SrEEKanTH
"""

import pandas as pd
import sys
import os
import re
import webbrowser
import smtplib
import requests

def responce():
    my_text = input(' Enter your query :\n > ')
    data = pd.read_csv("G:/Some Projects/Jarvis/sample.csv") 
    sk=[]
    for i in range(0,len(data)):
        if data.INPUT[i] == my_text:
            sk.append(data.OUTPUT[i])
    if len(sk)>0:
        sree = sk[0]
    else:
        sree= 'No Data Prsent for your query' 
    return sree   


    # The language changed by changing 'en' (PS: 'en' means English) search on [Language Codes according to ISO 639-1] file for more Languages and it's Abbreviation
    #tts = gTTS(text=my_text, lang='en', slow=False)
    #tts.save('converted-file.mp3')  
while True :
    print(responce())


