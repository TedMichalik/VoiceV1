# VoiceV1
Alexa on Google AIY Voice V1
****************************************************************
**Before Starting the setup**
****************************************************************
 
1. Create a security profile for alexa-avs-sample-app if you already don't have one.  
```
https://github.com/alexa/avs-device-sdk/wiki/Create-Security-Profile  
```

2. Download the **"config.json"** file.

3. Place the Alexa **config.json in** file in the  **/home/pi** directory.

***************************************************************
**Setup Audio**     
***************************************************************
4. Clone the git using:
```
git clone https://github.com/TedMichalik/VoiceV1.git
```    
**DO NOT RENAME THE CREDENTIALS FILEs**     
 
```
sudo /home/pi/VoiceV1/scripts/prep-system.sh
```    

5. Restart the Pi using:
```
sudo reboot
```    

6. Make sure that contents of asoundrc match the contents of asound.conf    
   Open a terminal and type:  
```
diff /home/pi/.asoundrc /etc/asound.conf
```

7. Test the audio setup using the following code (optional). Dont panic if the test does not go through successfully, proceed with the installation:
```
/home/pi/VoiceV1/scripts/audio-test.sh  
```

***************************************************************
**Install Alexa**     
***************************************************************
8. Install the assistant/assistants using the following. This is an interactive script, so just follow the onscreen instructions:
```
/home/pi/VoiceV1/scripts/alexa-installer.sh  
```
