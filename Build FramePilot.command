#!/bin/zsh
set -euo pipefail
cd -- "${0:A:h}"
if [[ ! -x .venv/bin/python ]]; then
  print 'Сначала запустите Start FramePilot.command для создания окружения.'
  exit 1
fi
.venv/bin/python -m pip install -e '.[build]'
PYINSTALLER_CONFIG_DIR="$PWD/.build/pyinstaller-cache" .venv/bin/python -m PyInstaller --noconfirm --workpath .build/pyinstaller FramePilot.spec
.venv/bin/python tools/package_app.py
print 'Готово: dist/FramePilot.app и установочный DMG в dist.'
