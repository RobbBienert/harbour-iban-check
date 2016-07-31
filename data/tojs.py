#!/usr/bin/env python3

from  pathlib import Path

DATA_IN = 'ibans.txt'
CODE_JS = '../qml/ibancheck.js'
code_js = Path(CODE_JS)
IN_MARK = '//--Countries'

def country(code, length, name):
	return '\t"{}": new Country({}),\t// {}'.format(
			code, length, name)

codeHead = codeTail = ''
st = 0

with open(CODE_JS, 'r') as f:
	for line in f:
		if 0 == st:
			if line[:-1] == IN_MARK:
				st = 1
			codeHead += line
		elif 1 == st:
			if line[:-1] == IN_MARK:
				codeTail += line
				st = 2
		elif 2 == st:
			codeTail += line

# backup copy the CODE_JS file
code_js.replace(CODE_JS + '.bak')

with open(CODE_JS, 'w') as c:
	print(codeHead, file=c)

	with open(DATA_IN, 'r') as f:
		print('var Lengths = {', file=c)

		for line in f:
			if len(line) == 0 or '#' == line[0]:
				continue

			fields = line.split('\t')

			print(country(fields[2][:2], fields[1][:-1], fields[0]), file=c)

		print(country('XX', 16, '*** example ***'), '\n}', file=c)

	print(codeTail, file=c)
