#!/bin/sh
for FILE in /work/keymaps/*.c; do
  FILENAME=${FILE#/work/keymaps/}
  NAME="${FILENAME%.c}"
  NEWFILENAME="/work/firmware/${NAME}.hex"
  KEYMAPFILENAME="/tmk/keyboard/alps64/keymap_${FILENAME}"
  cp "$FILE" "$KEYMAPFILENAME"
  cd /tmk/keyboard/alps64 && make "KEYMAP=$NAME" | ts >> "/work/logs/${NAME}-debug.log" 2>> "/work/logs/${NAME}-error.log"
  if test -f "$NEWFILENAME"; then
    mv "$NEWFILENAME" "${NEWFILENAME%.hex}-$(date +%Y.%m.%d-%H:%M:%S -r $NEWFILENAME).hex"
  fi
  cp "/tmk/keyboard/alps64/alps64.hex" "$NEWFILENAME"
  cd /tmk/keyboard/alps64 && make clean | ts >> "/work/logs/${NAME}-debug.log" 2>> "/work/logs/${NAME}-error.log"
  rm "$KEYMAPFILENAME"
done
