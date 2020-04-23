#! /bin/env/ python3

import re
from datetime import datetime
from pathlib import Path

filepath = Path(__file__)
prev = (filepath.parent / '..').resolve()

with (prev / 'README.md').open() as infile:
    text = infile.read()

with (prev / 'README.md').open('w') as out:
    print(re.sub(r"(?<=svg\?v=).+(?=\)])", str(abs(hash(datetime.now()))),
                 text), file=out)
