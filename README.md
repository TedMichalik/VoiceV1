# VoiceV1
Alexa on Google AIY Voice V1
****************************************************************
**Before Starting the setup**
****************************************************************
 
1. Create a security profile for alexa-avs-sample-app if you already don't have one.  
https://github.com/alexa/avs-device-sdk/wiki/Create-Security-Profile  

2. Download the **"config.json"** file.

3. Place the Alexa **config.json in** file in the  **/home/pi** directory.

***************************************************************
**Setup Audio**     
***************************************************************
1. Clone the git using:
```
git clone https://github.com/TedMichalik/VoiceV1  
```    
**DO NOT RENAME THE CREDENTIALS FILEs**     
 
 ```
sudo /home/pi/VoiceV1/scripts/prep-system.sh
```    

4. Restart the Pi using:
```
sudo reboot
```    

5. Make sure that contents of asoundrc match the contents of asound.conf    
   Open a terminal and type:  
```
sudo nano /etc/asound.conf
```
