#!/usr/bin/env python

import os
import fcntl
import shutil
import sys

file_ = os.path.expandvars('$RMUXDIR/my_history')
try:
	f = open(file_, 'r')
	lines = list(f.readlines())
	f.close()
except:
	f = open(file_, 'w')
	f.write('')
	f.close()

	lines = []

myset = set(lines)

file_bash = os.path.expandvars('$RMUXDIR/bash_history')
f = open(file_bash, 'r')
lines += list(f.readlines())
f.close()

lineset = set(lines)
diff = lineset - myset
if len(diff) == 0:
	sys.exit(0)
sys.stdout.write("+")
newlist = []
lines.reverse()
count = 0
for line in lines:
	if count > 6000:
		break
	if line in lineset:
		count += 1
		newlist.append(line)
		lineset.remove(line)
f = open(file_, 'w')
fcntl.flock(f.fileno(), fcntl.LOCK_EX)
newlist.reverse()
for line in newlist:
	f.write(line)
fcntl.flock(f.fileno(), fcntl.LOCK_UN)
f.close()
shutil.copyfile(file_, file_bash)
sys.exit(0)
