#!/bin/bash

# Generate qrc

QMLBASEDIR=qml
RESOURCEBASEDIR=resources
TMPQRC=.resources.qrc
QRC=resources.qrc

#<RCC>
#    <qresource prefix="/">
#        <file>main_ios.qml</file>
#        <file>home.qml</file>
#        <file>dev.qml</file>
#        <file>img/triangular.png</file>
#    </qresource>
#</RCC>

{
	echo "<RCC>"
	echo -ne '\t'
	echo "<qresource prefix=\"/qml\">"
	for i in `find ${QMLBASEDIR} -type f | grep -v .DS_Store`; 
		do
			echo -ne '\t\t'
			echo "<file>${i}</file>"
	done;
	echo -ne '\t'
	echo "</qresource>"
	echo -ne '\t'
	echo "<qresource prefix=\"/images\">"
	for i in `find ${RESOURCEBASEDIR} -type f | grep -v .DS_Store`; 
		do
			echo -ne '\t\t'
			echo "<file alias="\"${i##*/}\"">${i}</file>"
	done;
	echo -ne '\t'
	echo "</qresource>"
	echo "</RCC>"
} >> ${TMPQRC}


mv ${TMPQRC} ${QRC} 
cat ${QRC}
