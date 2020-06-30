# PythonのNativeAPIに挑戦／PythonからPyODBCを使ってInterSystems IRISに接続してみよう
##このGitでは、InterSystems IRIS の Python 用 NativeAPIの接続を確認できるサンプルと
PyODBC で IRIS への接続を確認できるサンプルコードを含んだコンテナを提供しています。

## コミュニティに公開しているビデオのサンプルコードです。

(1) [Python の NativeAPI に挑戦（ビデオ）](https://jp.community.intersystems.com/post/%E3%80%90%E3%81%AF%E3%81%98%E3%82%81%E3%81%A6%E3%81%AE-intersystems-iris%E3%80%91%E3%82%BB%E3%83%AB%E3%83%95%E3%83%A9%E3%83%BC%E3%83%8B%E3%83%B3%E3%82%B0%E3%83%93%E3%83%87%E3%82%AA%EF%BC%9A%E3%82%A2%E3%82%AF%E3%82%BB%E3%82%B9%E7%B7%A8%EF%BC%9Apython-%E3%81%AE-nativeapi-%E3%81%AB%E6%8C%91%E6%88%A6)

(2) [Python の PyODBC を使って IRIS に接続してみよう（ビデオ）](https://jp.community.intersystems.com/post/%E3%80%90%E3%81%AF%E3%81%98%E3%82%81%E3%81%A6%E3%81%AE-intersystems-iris%E3%80%91%E3%82%BB%E3%83%AB%E3%83%95%E3%83%A9%E3%83%BC%E3%83%8B%E3%83%B3%E3%82%B0%E3%83%93%E3%83%87%E3%82%AA%EF%BC%9A%E3%82%A2%E3%82%AF%E3%82%BB%E3%82%B9%E7%B7%A8%EF%BC%9Apython-%E3%81%8B%E3%82%89-pyodbc-%E3%82%92%E4%BD%BF%E3%81%A3%E3%81%A6-iris-%E3%81%AB%E6%8E%A5%E7%B6%9A%E3%81%97%E3%81%A6%E3%81%BF%E3%82%88%E3%81%86)


## Pythonのサンプルコードについて
サンプル環境では、コンテナを起動するだけで Python3 のサンプルコードも実行できるように、Python のインストールも含まれています。

また、Jupyterでの動作確認を行う場合のサンプルコードも提供しています。
サンプルファイルについては以下の通りです。

|ディレクトリ|ファイル|説明|
|:--|:--|:--|
|[jupyter-NativeAPI](/src/jupyter-NativeAPI)||Jupyter用のNativeAPIサンプルが含まれます|
||[HelloWorldNativeAPI.ipynb](/src/jupyter-NativeAPI/HelloWorldNativeAPI.ipynb)|IRISへの接続とグローバルへの値の設定、削除の簡単なサンプルコード|
||[Sake.ipynb](/src/jupyter-NativeAPI/Sake.ipynb)|[国税庁の酒税の課税関係等状況表　過年分（4月～3月）](https://www.nta.go.jp/taxes/sake/tokei/kanen.htm)を使用して都道府県別酒消費量をグローバルに設定するサンプルコード|
||[大阪のアルコール消費量.csv](/src/jupyter-nativeAPI/大阪のアルコール消費量.csv)|大阪のアルコール消費量のCSV|
||[東京のアルコール消費量.csv](/src/jupyter-nativeAPI/東京のアルコール消費量.csv)|東京のアルコール消費量のCSV|
|[jupyter-pyODBC](/src/jupyter-pyODBC)||Jupyter用のpyODBCサンプルが含まれます|
||[HelloWorldPyODBC.ipynb](/src/jupyter-pyODBC/HelloWorldPyODBC.ipynb)|IRISへpyODBC経由でアクセスしてテーブル作成、データ登録、SELECTの例が含まれます|
||[train.csv](/src/jupyter-pyODBC/train.csv)|サンプルコードで使用しているTitanicの乗客情報です（Kaggleからダウンロードした情報を利用しています）。|
|[nativeAPI_wheel](/src/nativeAPI_wheel)||nativAPI用インストールファイルが含まれます。|
|[pyodbc_wheel](/src/pyodbc_wheel)||IRIS用ODBCドライバの設定用ファイルが含まれます。|
|[python-nativeAPI](/src/python-nativeAPI)||コンテナ上で実行できる NativeAPIを利用したPythonのサンプルコードが含まれるディレクトリです。|
||[HelloWorldNativeAPI.py](/src/python-nativeAPI/HelloWorldNativeAPI.ipynb)|コンテナ上で実行できるNativeAPIのサンプルコード（IRISへの接続とグローバルの値設定、削除の簡単なサンプルコード）|
||[run.sh](/src/python-nativeAPI/run.sh)|NativeAPIのインストールと、サンプルコードで使用しているPythonライブラリのインストールも含めたシェル。（HelloWorldNativeAPI.pyとSake.pyを実行できます。）
||[Sake.py](/src/python-nativeAPI/Sake.ipynb)|コンテナ上で実行できる[国税庁の酒税の課税関係等状況表　過年分（4月～3月）](https://www.nta.go.jp/taxes/sake/tokei/kanen.htm)を使用して都道府県別酒消費量をグローバルに設定するサンプルコード|
||[大阪のアルコール消費量.csv](/src/python-nativeAPI/大阪のアルコール消費量.csv)|大阪のアルコール消費量のCSV|
||[東京のアルコール消費量.csv](/src/python-nativeAPI/東京のアルコール消費量.csv)|東京のアルコール消費量のCSV|
|[python-pyODBC](/src/python-pyODBC)||コンテナ上で実行できるのpyODBCサンプルが含まれます|
||[HelloWorldPyODBC.ipynb](/src/python-pyODBC/HelloWorldPyODBC.ipynb)|コンテナ上で実行できるPyODBCのサンプルで、IRISへpyODBC経由でアクセスしてテーブル作成、データ登録、SELECTの例が含まれます|
||[run.sh](/src/python-pyODBC/run.sh)|IRIS用ODBCのインストールと、サンプルコードで使用しているPythonライブラリのインストールも含めたシェル。（HelloWorldPyODBC.pyを実行できます。）
||[train.csv](/src/python-pyODBC/train.csv)|サンプルコードで使用しているTitanicの乗客情報です（Kaggleからダウンロードした情報を利用しています）。|
|:--|:--|:--|


## コンテナ起動までの手順

```
git clone このGitのURL
```
cloneしたディレクトリに移動後、以下実行します。

```
$ docker-compose build
```
ビルド後、コンテナを開始します。
```
$ docker-compose up -d
```
コンテナを停止する方法は以下の通りです。
```
$ docker-compose stop
```

## NativeAPIを体験する
コンテナにログイン後、[run.sh](/src/python-nativeAPI/run.sh) を実行すると、 NativeAPIのインポートと必要なPythonライブラリのインポートを実施し、[HelloWorldNativeAPI.py](/src/python-nativeAPI/HelloWorldNativeAPI.py)と[Sake.py](/src/python-nativeAPI/Sake.py) を実行します。
実行例は以下の通りです。
```
$ docker exec -it コンテナ名 bash
>cd /irisdev/app/src/python-NativeAPI
>./run.sh
```
Sake.py実行後、4種類のグラフの画像をカレントディレクトリに作成します。


## PyODBCを体験する
サンプルコードを実行する前に、IRISのODBCドライバをインストールするため odbcinst を実行してください。

odbcinst の実行には、root権限が必要なため一旦ユーザを root に切り替えて実行します。
なお、コンテナ内の root のパスワードは　root で設定しています。
※　コンテナ内に個人情報など大事なデータは登録されないようにご注意ください。

odbcinst の実行も含めた [run.sh](/src/python-PyODBC/run.sh) を用意しています。

run.shの中では[HelloWorldPyODBC.py](/src/python-PyODBC/HelloWorldPyODBC.py)を実行します。
実行例は以下の通りです。
```
$ docker exec -it コンテナ名 bash
>su -
> rootのパスワードを入力
>cd /irisdev/app/src/python-pyODBC
>./run.sh
```

