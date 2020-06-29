# Example Native API Application

Taken straight from https://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=AFL_pynative

## How to build this example

```
cd /irisdev/app/src/python

#Native API用インストール
pip3 install ../nativeAPI_wheel/irisnative-1.0.0-cp34-abi3-linux_x86_64.whl 

#PyODBC用インストール
odbcinst -i -d -f ../pyodbc_wheel/linux/odbcinst.ini

#pandasインストール
pip3 install pandas
```
## How to build and run this example in the container

```
python3 HelloWorldNativeAPI.py
pytho3 Sake.py
```
