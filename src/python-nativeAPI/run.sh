#!/bin/bash

echo "■Building(naitveAPI)..."
pip3 install ../nativeAPI_wheel/irisnative-1.0.0-cp34-abi3-linux_x86_64.whl 

#export LC_CTYPE="C.UTF-8" 

printf "\n■Executing(HelloWorldNativeAPI.py)..."
python3 HelloWorldNativeAPI.py

printf "\n■matplotlib　インストール..."
pip3 install matplotlib
printf "\n■Executing(Sake.py)..."
python3 Sake.py