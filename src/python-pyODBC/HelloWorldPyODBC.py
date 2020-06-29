#PyODBC を利用して InterSystems IRIS へ接続
#[1] pyodbc パッケージのインポート
#[2] IRISに接続
#[3] Create Tableの実行
#[4] CSVデータのロード（pandasパッケージのインポート）
#[5] CSVデータをIRISへ登録（INSERTの実行）
#[6] SELECTの実行(numpyパッケージのインポート)

#[1] pyodbcパッケージのインポート
import pyodbc

#[2] IRISに接続
connection=pyodbc.connect("DRIVER={InterSystems ODBC};SERVER=localhost;PORT=51773;DATABASE=user;UID=_system;PWD=SYS")
connection.setencoding(encoding='utf-8')

#[3] Create Tableの実行
create_table="CREATE TABLE Titanic.Passenger (PassengerId INTEGER, Survived  BIT, Pclass INTEGER,"\
 "Name VARCHAR(100), Sex VARCHAR(50), Age INTEGER,SibSp INTEGER, Parch INTEGER, "\
 "Fare VARCHAR(50), Ticket VARCHAR(50), Cabin VARCHAR(50), Embarked VARCHAR(50))"
cursor = connection.cursor()
cursor.execute(create_table)
connection.commit()

#[4] CSVデータのロード（pandasパッケージのインポート）
import pandas as pd
train=pd.read_csv("train.csv")
print(train.head())

#[5] CSVデータをIRISへ登録（INSERTの実行）
insertsql="insert into Titanic.Passenger "\
    "(PassengerId, Survived, Pclass, Name, Sex, Age, SibSp, Parch, Fare, Ticket, Cabin, Embarked) "\
    "values(?,?,?,?,?,?,?,?,?,?,?,?)"
cursor = connection.cursor()
for index, row in train.iterrows():
    cursor.execute(insertsql,row[0],row[1],row[2],row[3],row[4],row[5],row[6],row[7],row[8],row[9],row[10],row[11])
connection.commit()

#[6] SELECTの実行
import numpy as np
sql="SELECT PassengerId, Survived, Pclass, Name, Sex, Age, SibSp, Parch, Fare, Ticket, Cabin, Embarked FROM Titanic.Passenger"
cursor = connection.cursor()
cursor.execute(sql)
rows=cursor.fetchall()
data = pd.DataFrame(np.array(rows))
data.columns = ['PassengerId', 'Survived', 'Pclass','Name','Sex','Age','SibSp','Parch','Fare','Ticket','Cabin','Embarked']
print(data.head())

