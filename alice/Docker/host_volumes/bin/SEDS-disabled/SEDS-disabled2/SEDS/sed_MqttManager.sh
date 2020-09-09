#!/bin/bash

# Line 874
#exit

cd ~/ProjectAlice/core/server
/usr/bin/git checkout MqttManager.py

# Line 916
# gives this error.
# Caught exception in on_connect: [Errno 99] Cannot assign requested address
sed -i "s/\.*deviceList.append(self.ConfigManager.getAliceConfigByName('deviceName'))/# Removed by PS - Line 916 causes 'Caught exception in on_connect: [Errno 99] Cannot assign requested address'/" ./MqttManager.py



# Before new audio-server
#sed -i "s/\.*deviceList = \[device.name.replace('@mqtt', '') for device in self.DeviceManager.getDevicesByType('AliceSatellite', connectedOnly=True)\]/Paste right here/" ./MqttManager.py

#sed -i "874,1d " ./MqttManager.py

#sed -i "s/\.*Paste right here/# Changed by PS\n\t\tdeviceList = [device.name.replace('@mqtt', '') for device in self.DeviceManager.getDevicesByType('AliceSatellite', connectedOnly=True)]\n\t\tif not self.ConfigManager.getAliceConfigByName('disableSoundAndMic'):\n\t\t\tdeviceList.append(constants.DEFAULT_SITE_ID)/"  ./MqttManager.py



# After new audio-server
# sed -i "s/\.*deviceList = \[device.name.replace(self.DEFAULT_CLIENT_EXTENSION, '') for device in self.DeviceManager.getDevicesByType('AliceSatellite', connectedOnly=True)\]/Paste right here/" ./MqttManager.py

#  sed -i "889,1d " ./MqttManager.py

#  sed -i "s/\.*Paste right here/# Changed by PS\n\t\tdeviceList =  [device.name.replace(self.DEFAULT_CLIENT_EXTENSION, '') for device in self.DeviceManager.getDevicesByType('AliceSatellite', connectedOnly=True)]\n\t\tif not self.ConfigManager.getAliceConfigByName('disableSoundAndMic'):\n\t\t\tdeviceList.append(constants.DEFAULT_SITE_ID)/"  ./MqttManager.py


# Under docker og brug snips-satelite, så kan vi ikke sende/connecte  til default device, da det ikke eksisterer
# def toggleFeedbackSounds(self, state='On'):
#     """
#     Activates or disables the feedback sounds, on all devices
#     :param state: str On or off
#     """

#     deviceList = [device.name.replace(self.DEFAULT_CLIENT_EXTENSION, '') for device in self.DeviceManager.getDevicesByType(deviceType=self.DeviceManager.SAT_TYPE, connectedOnly=True)]
#     deviceList.append(self.ConfigManager.getAliceConfigByName('deviceName'))

#     self.logDebug(f"###################################### In toggleFeedbackSounds - deviceList: {deviceList}\n\n ")
#     for siteId in deviceList:
#       self.logDebug(f"####################################### In toggleFeedbackSounds - siteId: {siteId}  ")
#       #publish.single(constants.TOPIC_TOGGLE_FEEDBACK.format(state.title()), payload=json.dumps({'siteId': siteId}))
#       self.logDebug(f"####################################### After publish - siteId: {siteId}  ")



# sed -i "s/publish.single(constants.TOPIC_TOGGLE_FEEDBACK.format(state.title()), payload=json.dumps({'siteId': siteId}))/#publish.single(constants.TOPIC_TOGGLE_FEEDBACK.format(state.title()), payload=json.dumps({'siteId': siteId}))\n\t\t\tpass/" ./MqttManager.py


# ############
# Line ca. 226

#         if session.notUnderstood <= self.ConfigManager.getAliceConfigByName('notUnderstoodRetries'):
#           session.notUnderstood = session.notUnderstood + 1

#           self.continueDialog(
#             sessionId=sessionId,
#             text=self.TalkManager.randomTalk('notUnderstood', skill='system'),
#             probabilityThreshold=session.probabilityThreshold,
#             intentFilter=session.intentFilter
#           )

#           # self.broadcast(method=constants.EVENT_INTENT_NOT_RECOGNIZED, exceptions=[self.name], propagateToSkills=True, session=session)
#           # session.notUnderstood = 0
#           # self.endDialog(
#           #   sessionId=sessionId,
#           #   text=self.TalkManager.randomTalk('notUnderstoodEnd', skill='system')
#           # )
#         else:
#           session.notUnderstood = 0
#           self.endDialog(
#             sessionId=sessionId,
#             text=self.TalkManager.randomTalk('notUnderstoodEnd', skill='system')
#           )
#         return



