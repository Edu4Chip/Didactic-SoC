#!/bin/bash

getopts f: FLAG
FILE="$OPTARG"

echo $FILE

if [ $FLAG != "f" ]
then
  echo "Please provide -f option to run_kactus2_script.sh." >&2
  exit 1
fi

# Replace this path with your local kactus2 install path
KACTUSPATH="${KACTUSPATH:=/opt/soc/eda/tuni/kactus2}"
PATH=$KACTUSPATH:$PATH
CONFPATH=~/.config/TUT
CONFFILE=Kactus2.ini

# Replace these paths with your compiled python and swig path
PYTHONINSTALL=/opt/soc/eda/tuni/python3.9
PATH=$PYTHONINSTALL/bin:$PATH
PATH=/opt/soc/eda/tuni/swig/bin:/$PATH

# Copy the default config file, if no config file found
if [ ! -f $CONFPATH/$CONFFILE ]; then
  echo "Creating default settings"
  mkdir -p $CONFPATH
  cp $KACTUSPATH/xdg/* $CONFPATH
fi

KACTUS2='LD_LIBRARY_PATH=$KACTUSPATH:$PYTHONINSTALL/lib:$LD_LIBRARY_PATH PYTHONPATH="$KACTUSPATH/PythonAPI" $KACTUSPATH/kactus2'


eval "$KACTUS2 -c < $FILE"
