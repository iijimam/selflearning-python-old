#都道府県別酒消費量をグロ―バルに設定する
#データ取得元：国税庁の酒税の課税関係等状況表(https://www.nta.go.jp/taxes/sake/tokei/kanen.htm)　過年分（4月～3月）

#[1] パッケージのインポート
#CSVファイルをロードするために pandasパッケージのインポートと、Native APIの利用のためにirisnativeパッケージをインポートする
import pandas as pd
import irisnative

#[2] IRISへの接続とIRISオブジェクトの作成
connection = irisnative.createConnection("localhost",51773,"user","_system","SYS")
iris_native = irisnative.createIris(connection)

#[3]読み込んだCSVをグローバルに登録
#pandasのDataFrameに「東京のアルコール消費量.CSV」の中身をロードし（Tokyo）、以下グローバルに設定
#グローバル^Alcohol("東京",年)="清酒,合成清酒,連続式蒸留焼酎,単式蒸留焼酎,ビール,発泡酒,成人人口(千人）,成人一人当たりの消費量(L)"
#DataFrameの行が取得できたらtolist()関数でリストに変換、join()メソッドを利用してリストをカンマ区切りの文字列に変換
#
#年（listdata[0]）を ^Alcohol()の第2サブスクリプトに設定するため、作成する文字列は、 listdata[1:] で取得するデータを確認します
#管理ポータル（localhost:52772/csp/sys/UtilHome.csp）を開き、システムエクスプローラ→グロ－バル→左側でネームスペースを選択し、^Alcohol　を表示します

Tokyo=pd.read_csv("東京のアルコール消費量.csv")

for index, row in Tokyo.iterrows():
    listdata = row.astype(str).tolist()  #文字列のリストに変換
    mojiretu = ','.join(listdata[1:])    #リストを文字列に変換（区切り文字は何でもOK）
    iris_native.set(mojiretu, "Alcohol","東京",listdata[0])

#pandasのDataFrameに「大阪のアルコール消費量.CSV」の中身をロードし（Osaka）、以下グローバルに設定
#^Alcohol("大阪",年)="清酒,合成清酒,連続式蒸留焼酎,単式蒸留焼酎,ビール,発泡酒,成人人口(千人）,成人一人当たりの消費量(L)"
Osaka=pd.read_csv("大阪のアルコール消費量.csv")
for index, row in Osaka.iterrows():
    listdata = row.astype(str).tolist()  #文字列のリストに変換
    mojiretu = ','.join(listdata[1:])    #リストを文字列に変換（区切り文字は何でもOK）
    iris_native.set(mojiretu, "Alcohol","大阪",listdata[0])

#[4]東京のデータだけ取得する
#^Alcohol("東京",★)　　★の第2サブスクリプトをループしデータを取得し、DataFrameに登録し、中身を確認します。
#DataFrame のカラム名は以下の通り
#['Year','Sake', 'SyntheticSake','ContinuousDistilledShochu','SingleDistilledShochu','Beer','LowMaltBeer','Adult']
alcohol=[]
ite=iris_native.iterator("Alcohol","東京")
for year,data in ite.items():
    row=data.split(",")  #文字列→りストに変換
    row.insert(0,year)   #リストの先頭にYearを追加
    alcohol.append(row)

df1=pd.DataFrame(alcohol,columns=['Year','Sake', 'SyntheticSake','ContinuousDistilledShochu','SingleDistilledShochu','Beer','LowMaltBeer','Adult'])
print(df1.head())

#[5]全件ロードしてみる
#^Alcohol()の第1と第2サブスクリプトをループします。
#DataFrame のカラム名は以下の通り
#['Year','Sake', 'SyntheticSake','ContinuousDistilledShochu','SingleDistilledShochu','Beer','LowMaltBeer','Adult']
gloall=[]
ite1= iris_native.iterator("Alcohol")
for area in ite1.subscripts():
    ite2=iris_native.iterator("Alcohol",area)
    for year,value in ite2.items():
        moji=area + "," + year +"," + value
        gloall.append(moji.split(","))
df2=pd.DataFrame(gloall,columns=['Area','Year','Sake', 'SyntheticSake','ContinuousDistilledShochu','SingleDistilledShochu','Beer','LowMaltBeer','Adult'])
print(df2.head())

#[6]東京のデータだけを削除します
#データを確認します
#管理ポータル（localhost:52772/csp/sys/UtilHome.csp）を開き、システムエクスプローラ→グロ－バル→左側でネームスペースを選択し、^Alcohol　を表示します
iris_native.kill("Alcohol","東京")


#おまけ グラフ表示
#matplotlib の pyplotパッケージをインポートして、東京のビールと発泡酒の消費をグラフ化します。
from matplotlib import pyplot as plt
Tokyo[["Beer","LowMaltBeer"]].plot(title="Tokyo")
plt.savefig('plotTokyo.png')

#おまけ2：大阪の情報もグラフ表示
#大阪のビールと発泡酒消費量もグラフ化します。
Osaka[["Beer","LowMaltBeer"]].plot(title="Osaka")
plt.savefig('plotOsaka.png')

#おまけ3：東京・大阪の連続蒸留焼酎と単式蒸留焼酎の折れ線グラフ
Tokyo[['ContinuousDistilledShochu', 'SingleDistilledShochu']].plot(title="Tokyo")
plt.savefig('plotTokyo2.png')

Osaka[['ContinuousDistilledShochu', 'SingleDistilledShochu']].plot(title="Osaka")
plt.savefig('plotOsaka2.png')
