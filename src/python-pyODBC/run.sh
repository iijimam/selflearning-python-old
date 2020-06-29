#!/bin/bash

printf "\n■odbcinstのインストール..."


printf "\n■Building(pyODBC)..."
odbcinst -i -d -f ../pyodbc_wheel/linux/odbcinst.ini

printf "\n■Executing(HelloWorldPyODBC.py)..."
python3 HelloWorldPyODBC.py
