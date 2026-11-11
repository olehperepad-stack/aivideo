#!/bin/zsh
set -euo pipefail
cd -- "${0:A:h}"

if [[ ! -x .venv/bin/python ]]; then
  interpreter=""
  for candidate in /Library/Frameworks/Python.framework/Versions/3.13/bin/python3.13 /opt/homebrew/bin/python3 /usr/local/bin/python3; do
    if [[ -x "$candidate" ]]; then
      interpreter="$candidate"
      break
    fi
  done
  if [[ -z "$interpreter" ]]; then
    print 'Установите Python 3.11 или новее с https://www.python.org/downloads/macos/'
    read '?Нажмите Enter для выхода…'
    exit 1
  fi
  "$interpreter" -m venv .venv
fi

if ! .venv/bin/python -c 'import cv2, numpy, PySide6, Vision, ScreenCaptureKit, websocket, imageio_ffmpeg' >/dev/null 2>&1; then
  .venv/bin/python -m pip install -e .
fi

.venv/bin/python -m framepilot --demo
