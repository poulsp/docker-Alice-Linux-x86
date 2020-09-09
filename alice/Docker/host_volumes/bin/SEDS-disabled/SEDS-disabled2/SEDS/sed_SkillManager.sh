#!/bin/bash

# Line: 104
cd ~/ProjectAlice/core/base
/usr/bin/git checkout ~/ProjectAlice/core/base/SkillManager.py

sed -i "s/\.*self.logError(f\"Couldn't instanciate skill {skillName}.{skillResource}: {e} {traceback.print_exc()}\")/self.logFatal(f\"Couldn't instanciate skill {skillName}.{skillResource}: {e} {traceback.print_exc()}\")/"  ./SkillManager.py
