#!/bin/bash


cd ~/ProjectAlice/skills/AliceCore
/usr/bin/git checkout ~/ProjectAlice/skills/AliceCore/AliceCore.py

# don't allow Alice to update the debian system.
sed -i "s/\.*self.ThreadManager.doLater(interval=2,.*func=self\.systemUpdate)/# Line removed by PS\n/" ~/ProjectAlice/skills/AliceCore/AliceCore.py


# In def stopListenIntent
sed -i "s/\.*self.Commons.runRootSystemCommand(\['systemctl', 'stop', 'snips-hotword'\])/# Changed by PS\n\t\t\tself.notifyDevice(constants.TOPIC_DND, siteId=session.siteId)\n\t\t\tself.Commons.runRootSystemCommand(\['systemctl', 'stop', 'snips-hotword'\])/" ~/ProjectAlice/skills/AliceCore/AliceCore.py



# In def unmuteSite
sed -i "s/\.*self.Commons.runRootSystemCommand(\['systemctl', 'start', 'snips-hotword'\])/# Changed by PS\n\t\t\t\self.notifyDevice(constants.TOPIC_STOP_DND, siteId=siteId)\n\t\t\tself.Commons.runRootSystemCommand(\['systemctl', 'start', 'snips-hotword'\])/" ~/ProjectAlice/skills/AliceCore/AliceCore.py
