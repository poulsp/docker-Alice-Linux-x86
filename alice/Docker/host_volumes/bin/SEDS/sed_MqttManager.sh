#!/bin/bash

# Line 874

cd ~/ProjectAlice/core/server
/usr/bin/git checkout MqttManager.py


sed -i "s/\.*deviceList = \[device.name.replace('@mqtt', '') for device in self.DeviceManager.getDevicesByType('AliceSatellite', connectedOnly=True)\]/Paste right here/" ./MqttManager.py

sed -i "874,1d " ./MqttManager.py

sed -i "s/\.*Paste right here/# Changed by PS\n\t\tdeviceList = [device.name.replace('@mqtt', '') for device in self.DeviceManager.getDevicesByType('AliceSatellite', connectedOnly=True)]\n\t\tif not self.ConfigManager.getAliceConfigByName('disableSoundAndMic'):\n\t\t\tdeviceList.append(constants.DEFAULT_SITE_ID)/"  ./MqttManager.py



