#InterSystems IRIS の Python Native APIを使ってみよう
######################################
#[1] irisnative パッケージのインポート
#[2] IRISに接続＋IRISオブジェクトの作成
#[3] ^employee(1)="田口" の作成
#[4] [3]で設定した値の取得
#[5] ^employee(2)="秋山" の作成
#[6] 全件取得
#[7] ^employee(1)の削除
######################################

#[1] irisnative パッケージのインポート
import irisnative
#[2]IRISに接続＋IRISオブジェクトの作成
connection = irisnative.createConnection("localhost",51773,"user","_system","SYS")
iris_native = irisnative.createIris(connection)

#[3] ^employee(1)="田口"の作成
iris_native.set("田口","employee",1)

#[4] [3]で作成した ^employee(1)の取得
print(iris_native.get("employee",1))

#[5] ^employee(2)="秋山" の作成
iris_native.set("秋山","employee",2)

#[6] 全件取得
for key,value in iris_native.iterator("employee"):
    print(key,"-",value)

#[7] ^employee(1)の削除
iris_native.kill("employee",1)

#接続終了
connection.close()
