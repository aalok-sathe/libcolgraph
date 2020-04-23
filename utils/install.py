#!/usr/bin/env python3

import re
from pathlib import Path
import sys

path = Path(__file__).parent / '../requirements.txt'

newtxt = ''
with path.open() as f:
    txt = f.read()
    newtxt = re.sub('==', '>=', txt)

with path.open(mode='w') as f:
    f.write(newtxt)

raise SystemExit
