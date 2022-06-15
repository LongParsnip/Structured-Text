# Structured Text User Defined Functions (UDF) Library
This is a repository of all the custom user defined functions I have developed.

## How to get the files?:
I will place builds inside the builds folder of the IDE I was using at the time (Likely to be Connected Components Workbench).
You may recreate the UDF inside the IDE of your choosing by either importing (if possible) or just copying and pasting the source code.

## What is the purpose exactly?
The push for manufacturers to make IEC61131 is a good thing but the base library is very limited, complex reusable functions can be developed by encapsulating them in structured text.
I publish my works incase someone finds them useful, that is all.



# User Defined Functions List:

## Auxiliary:
* HSCENC:     (LADDER) High speed counter for a pulse input (Micro850), can be used in conjunction with a SCP_ST block to create a RPM indicator from a pulse input.
* SCP_ST:     Scale with parameters. Takes an input and scales it with user configured params.

## Device Control:
* DEVCTL:     Device control block for digital devices, includes state tracking, override interlocks, permissive interlocks and configurable alarm conditions.
* RESETGOP:   Required component of the DEVCTL block, a bit of a nasty work around until I find a better solution.

## Logic:
* GTA:            Greater than block with deadband.
* LTA:            Less than block with deadband.
* TON_Pausable:   A pausable TON function, adds an additional input so that you may suspend the timing operation without resetting it.
* TRIG:           A trigger block with TON/TOF functionality in a single function.

## Utility:
* DIDOREF:      Reference block for a DI/DO tag, usefull mostly for allowing you to indicate the IO clearly and invert if required.
* FLASHER:      Generates an ON/OFF output with configurable time when the Input is On.


# Project Builds:
I have also build some project files for more complex reusable systems.
These can be found in the builds directory.

## Annunciator (FBD & ST):
A 19 output + 1 siren annunciator panel program for a Micro850 PLC (28DI/20DO).
* Acknowledge Button Input.
* Audible Siren Output.
* Synchronised Flashing Operator.
* Exandable, just add more IO and copy and paste the function blocks.

