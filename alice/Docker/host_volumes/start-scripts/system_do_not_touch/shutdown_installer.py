#!/home/pi/ProjectAlice/venv/bin/python
# encoding: utf-8

#######!/usr/bin/env python3

## Description: A real killer app.

import sys
import signal
def terminateProcess(signalNumber, frame):
	sys.exit()
signal.signal(signal.SIGTERM, terminateProcess)
signal.signal(signal.SIGINT, terminateProcess)

import psutil
import os
import time


#-----------------------------------------------
def getProcesses() -> dict:
		"""Return a dict of processes."""

		dct = dict()
		for p in psutil.process_iter(["pid", "name", "cmdline"]):
						dct.update({p.info["pid"]: {"cmdline": p.info["cmdline"]}})
		return dct


#-----------------------------------------------
def getPidForStartScripts() -> int:
	key = -1
	processDict = getProcesses()
	for key in processDict:
		try:
			if	(	processDict[key]["cmdline"][1] == "/start-scripts/start-alice-manual.sh" or
						processDict[key]["cmdline"][1] == "/start-scripts/start-alice-automatic.sh"or
						processDict[key]["cmdline"][2] == "/etc/mosquitto/mosquitto.conf"	):

				return key
		except Exception as e:
			pass


#-----------------------------------------------
def checkTraining() -> bool:
	retVal = False
	processDict = getProcesses()
	for key in processDict:
		try:
			if processDict[key]["cmdline"][2] == "train":
				retVal = True
		except Exception as e:
			pass

	return retVal


#-----------------------------------------------
if __name__ == "__main__":

		isTraining = False

	#try:
		while not checkTraining():
			time.sleep(5)

		isTraining = True
		print(f"Waiting for Alice to end training.")


		while isTraining:
			time.sleep(5)
			if not checkTraining():
				isTraining = False

		pid =  getPidForStartScripts()
		if pid == -1:
			raise Exception(f'Something went wrong, Wrong pid: {pid}')


		print(f"do some killing - kill -9 {pid}")
		os.system(f"kill -9 {pid}  > /dev/null 2>&1 &")



