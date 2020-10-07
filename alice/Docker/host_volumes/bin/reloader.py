#!/home/pi/ProjectAlice/venv/bin/python
# encoding: utf-8

#######!/usr/bin/env python3

import sys
import signal
def terminateProcess(signalNumber, frame):
	sys.exit()

import psutil
import os
import subprocess
import time
from threading import Timer
import requests
import json

try:
	from watchdog.observers import Observer
except ModuleNotFoundError:
	os.system("/home/pi/ProjectAlice/venv/bin/pip install watchdog")
	from watchdog.observers import Observer

from watchdog.events import PatternMatchingEventHandler

sys.path.append('/home/pi/ProjectAlice')
#from config import(settings)

#-----------------------------------------------
class ProgramKilled(Exception):
	pass


#-----------------------------------------------
def signal_handler(signum, frame):
		raise ProgramKilled

signal.signal(signal.SIGTERM, signal_handler)
signal.signal(signal.SIGINT, signal_handler)


#-----------------------------------------------
class Reloader():
	"""docstring for Reloader"""
	def __init__(self, skillName, authToken):
		self.skillName = skillName
		self.authToken = authToken

		self.timerStartAlice = None
		self.isInStartAlice = False
		#self.AliceConfigs = settings
		self.readConfig()
		self.webInterfaceActive = self.getConfig('webInterfaceActive')
		#self.webInterfaceActive = settings["webInterfaceActive"]
		# __pycache__
		self.patterns = "*"
		self.ignore_patterns = ""
		self.ignore_directories = False
		self.case_sensitive = True

		self.onStart()

		# create the event handler
		self.eventHandler = PatternMatchingEventHandler(self.patterns, self.ignore_patterns,
			self.ignore_directories, self.case_sensitive)

		# Handle all the events
		self.eventHandler.on_modified = self.on_modified

		# Observer
		os.chdir("/home/pi/ProjectAlice/skills")
		self.path = sys.argv[1] if len(sys.argv) > 1 else '.'

		self.recursive = True
		self.observer = Observer()
		self.observer.schedule(self.eventHandler, self.path, recursive=self.recursive)
		self.observer.start()

#-----------------------------------------------
	def readConfig(self):
		with open('config.json') as config_file:
				self._config = json.load(config_file)


	#-----------------------------------------------
	def getConfig(self, configName: str):
		return self._config[configName]


	#-----------------------------------------------
	def onStart(self):
		if self.webInterfaceActive:
			print(f"Alice Web Interface is Active")
			print(f"Reloader runs best when Alice Web Interface is not active.")
			print(f"If you do not absolutely need to use the interface then turn it off.")
			print(f"This means a speed increase of 1.5 seconds at restart.")

	#-----------------------------------------------
	def startAlice(self):
		if self.isInStartAlice:
			return
		#print("er  i startAlice")
		self.isInStartAlice = True
		os.system("/home/pi/bin/alice-start > /dev/null 2>&1 &")

		if self.timerStartAlice != None:
			self.timerStartAlice.cancel()
		self.isInStartAlice = False


	#-----------------------------------------------
	def getProcs(self) -> dict:
			dct = dict()
			for p in psutil.process_iter(["pid", "name", "cmdline"]):
							dct.update({p.info["pid"]: {"cmdline": p.info["cmdline"]}})
			return dct


	#-----------------------------------------------
	def on_modified(self, event):
		procsDict = self.getProcs()
		for key in procsDict:
			if 'train' in procsDict[key]["cmdline"]:
				print('Alice is training, wait a while and then enter "ctrl-s" again.')
				print()
				return

		# wwreloader.py	TextInputWidget
		if event.src_path.find("__pycache__") == -1:

			# # We do not use reload because it does not work on all skills.
			# if event.src_path.find("widgets") == 16:
			# 	print(f'\nReload, a file is modified, "{event.src_path}", ProjectAlice reloaded through API')
			# 	#"TextInputWidget/widgets/SimpleCommand.py"
			# 	self.reloadApiCall()
			# 	return

			print(f'\nReload, a file is modified, "{event.src_path}", ProjectAlice restarted')
			os.system("kill -2 `ps ax|grep 'venv/bin/python main.py'|grep -v 'grep'|  awk '{print $1}'` > /dev/null 2>&1 &")

			#Read the Alice config.py and determine if "webInterfaceActive": True or False,
			# if true then increase the timer delay interval from 1.0 secs to ??? 2.5 secs.
			if self.webInterfaceActive:
				self.timerStartAlice = Timer(2.5, self.startAlice)
			else:
				self.timerStartAlice = Timer(1.0, self.startAlice)

			self.timerStartAlice.start()
			print()

	#-----------------------------------------------
	def reloadApiCall(self):
		#curl --location --request POST 'http://localhost:5000/api/v1.0.1/login/?=' --form 'username=' --form 'pin='

		url = f"http://localhost:5000/api/v1.0.1/skills/{self.skillName}/reload/"

		payload = {'': ''}
		files = []
		headers = {
			'auth': self.authToken
		}

		response = requests.request("GET", url, headers=headers, data = payload, files = files)

		print(response.text.encode('utf8'))

#-----------------------------------------------
if __name__ == "__main__":

	#Todo a command line parameter -c fullpath/a_Alice_core_file to change or play with
	# instead of skills.
	if len(sys.argv) < 2:
		print()
		print('You must provide a Skill to watch')
		print(('Example: ' + os.path.basename(sys.argv[0]) + ' <command> ≃ Lights'))
		print()
		sys.exit(1)

	#TODO Read AuthToken from file. If we want to use it.
	AuthToken = ""
	reloader = Reloader(os.path.basename(sys.argv[1]), AuthToken)

	if not os.path.exists('/home/pi/.alice-started'):
		reloader.timerStartAlice = Timer(1.0, reloader.startAlice)
		reloader.timerStartAlice.start()

	try:
		print('Launching your command, "ctrl-c" to stop\n')
		while True:
			time.sleep(1)
	except ProgramKilled:
		print("\nProgram killed: running cleanup code")
		os.system("kill -2 `ps ax|grep 'venv/bin/python main.py'|grep -v 'grep'|  awk '{print $1}'` > /dev/null 2>&1 &")
		try:
			os.unlink("/home/pi/.alice-started'")
		except Exception as e:
			pass
		try:
			reloader.observer.stop()
			reloader.observer.join()
		except Exception as e:
			print(e)

