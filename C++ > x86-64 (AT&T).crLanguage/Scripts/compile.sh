#!/bin/bash
# This is a CodeRunner compilation script. Compilation scripts are used to
# compile code before being run using the run command specified in CodeRunner
# preferences. This script should have the following properties:
#
# Launch directory ($PWD):		Will be the same as the file being run
#
# Exit status:					Should be 0 on success (will cause CodeRunner
#								to continue and execute the run command)
#
# Output (stdout):				On success, one line of text which can be accessed
#								using the $compiler variable in the run command
#
# Output (stderr):				Anything outputted here will be displayed in
#								the CodeRunner console
#
# Environment:					$CR_FILENAME	Filename of the source file
#								$CR_ENCODING	Encoding of the source file
#								${@:1}	Compilation flags set in CodeRunner preferences
#								$CR_TMPDIR	Path of a temporary directory (without / suffix)
#
# The encoding argument may be used to specify to the compiler which encoding
# the source file uses. It will be one of the integers in the following array:

enc[4]="UTF-8"				# UTF-8
enc[10]="UTF-16"			# UTF-16
enc[5]="ISO-8859-1"			# ISO Latin 1
enc[9]="ISO-8859-2"			# ISO Latin 2
enc[30]="MacRoman"			# Mac OS Roman
enc[12]="CP1252"			# Windows Latin 1
enc[3]="EUC-JP"				# Japanese (EUC)
enc[8]="SHIFT_JIS"			# Japanese (Shift JIS)
enc[1]="ASCII"				# ASCII


compname=`echo "$CR_FILENAME" | sed 's/\(.*\)\..*/\1/'`
clang++ "$CR_FILENAME" -o "$compname" -c -S -mcpu=core-avx2 -O3 ${@:1}
status=$?
if [ $status -eq 0 ]
then
echo $compname
exit 0
elif [ $status -eq 127 ]
then
echo -e "\nTo run code in this language, you need to have compilers installed. These are bundled with Xcode which can be downloaded through the Mac App Store or Apple's developer site. \n\nIf you are using Xcode 4.3 or later, you need to open Xcode preferences, select the Downloads pane, and choose to install 'Command Line Tools'. This may require an Apple developer account, which is free."
fi
exit $status