*** Settings ***
Documentation	Basic start and exit tests

Library	OperatingSystem
Library	Process
Library	libraries/sendKey.py
Library	libraries/nvdaRobotLib.py

Test Setup	start NVDA	standard-dontShowWelcomeDialog.ini
Test Teardown	quit NVDA

Variables	variables.py

*** Test Cases ***
Ensure NVDA runs at all
	process should be running	nvdaAlias

Ensure NVDA quits from keyboard
	[Setup]	start NVDA	standard-doShowWelcomeDialog.ini
	send key	insert	tab
	send key	insert	q
	sleep	1
	send key	insert	tab
	wait for foreground	Exit NVDA
	send key	insert	tab
	send key	enter
	sleep	1
	send key	insert	tab
	wait for process	nvdaAlias	timeout=5 sec
	process should be stopped	nvdaAlias

Can read the welcome dialog
	[Setup]	start NVDA	standard-doShowWelcomeDialog.ini
	assert all speech	${WELCOME_DIALOG_TEXT}
	send key	enter
