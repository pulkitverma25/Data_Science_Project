# Original Script Source: http://code.activestate.com/recipes/577423-convert-csv-to-xml/
# Edited By: technopreneur[dot]pulkit[at]gmail[dot]com
# First row of the tsv file(s) must be the header!

import sys
import os
import glob

delimiter = "\t" # "\t" "|" # delimiter used in the tsv file(s)

# the optional command-line argument maybe a tsv file or a folder
if len(sys.argv) == 2:
    arg = sys.argv[1].lower()
    if arg.endswith('.tsv'): # if a tsv file then convert only that file
        tsvFiles = [arg]
    else: # if a folder path then convert all tsv files in the that folder
        os.chdir(arg)
        tsvFiles = glob.glob('*.tsv')
# if no command-line argument then convert all tsv files in the current folder
elif len(sys.argv) == 1:
    tsvFiles = glob.glob('*.tsv')
else:
    os._exit(1)

z=1
for tsvFileName in tsvFiles:
	# read the tsv file as binary data in case there are non-ASCII characters
	tsvFile = open(tsvFileName, 'rb')
	tsvData = tsvFile.readlines()
	tsvFile.close()
	tags = tsvData.pop(0).strip().replace(' ', '_').split(delimiter)
	for row in tsvData:
		xmlFile = 'match_'+ str(z) + '.txt'
		z+=1
		print(z)
		
		xmlData = open(xmlFile, 'w')
		# there must be only one top-level tag
		rowData = row.strip().split(delimiter)
		for i in range(len(tags)):
			xmlData.write('#' + tags[i].upper() + ' ' \
			+ rowData[i] + "\n")
		xmlData.close()

