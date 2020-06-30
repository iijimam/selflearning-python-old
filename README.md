# PythonのNativeAPIに挑戦／PythonからPyODBCを使ってInterSystems IRISに接続してみよう
このGitでは、InterSystems IRIS の Python 用 NativeAPIの接続を確認できるサンプルと
PyODBC で IRIS への接続を確認できるサンプルコードを含んだコンテナを提供しています。
コンテナは、[InterSystems IRIS Community Editionのイメージ](https://hub.docker.com/_/intersystems-iris-data-platform)を使用しています（Pullできない場合はイメージ、タグ名ごご確認ください）。
また、Python3 が実行できるように、Python のインストールも含まれます。
詳細は、[Dockerfile](./Dockerfile) をご参照ください。


## コミュニティに公開しているビデオのサンプルコードです。

(1) [Python の NativeAPI に挑戦（ビデオ）](https://jp.community.intersystems.com/post/%E3%80%90%E3%81%AF%E3%81%98%E3%82%81%E3%81%A6%E3%81%AE-intersystems-iris%E3%80%91%E3%82%BB%E3%83%AB%E3%83%95%E3%83%A9%E3%83%BC%E3%83%8B%E3%83%B3%E3%82%B0%E3%83%93%E3%83%87%E3%82%AA%EF%BC%9A%E3%82%A2%E3%82%AF%E3%82%BB%E3%82%B9%E7%B7%A8%EF%BC%9Apython-%E3%81%AE-nativeapi-%E3%81%AB%E6%8C%91%E6%88%A6)

(2) [Python の PyODBC を使って IRIS に接続してみよう（ビデオ）](https://jp.community.intersystems.com/post/%E3%80%90%E3%81%AF%E3%81%98%E3%82%81%E3%81%A6%E3%81%AE-intersystems-iris%E3%80%91%E3%82%BB%E3%83%AB%E3%83%95%E3%83%A9%E3%83%BC%E3%83%8B%E3%83%B3%E3%82%B0%E3%83%93%E3%83%87%E3%82%AA%EF%BC%9A%E3%82%A2%E3%82%AF%E3%82%BB%E3%82%B9%E7%B7%A8%EF%BC%9Apython-%E3%81%8B%E3%82%89-pyodbc-%E3%82%92%E4%BD%BF%E3%81%A3%E3%81%A6-iris-%E3%81%AB%E6%8E%A5%E7%B6%9A%E3%81%97%E3%81%A6%E3%81%BF%E3%82%88%E3%81%86)



## ディレクトリ／サンプルファイルについて
コンテナには、Pythonのサンプルコードがあります。また、Jupyter用のサンプルコードも用意しています。
サンプルファイルについて詳細は以下の通りです。

|ディレクトリ|ファイル|説明|
|:--|:--|:--|
|[jupyter-NativeAPI](/src/jupyter-NativeAPI)||Jupyter用のNativeAPIサンプルが含まれます|
||[HelloWorldNativeAPI.ipynb](/src/jupyter-NativeAPI/HelloWorldNativeAPI.ipynb)|IRISへの接続とグローバルへの値の設定、削除の簡単なサンプルコード|
||[Sake.ipynb](/src/jupyter-NativeAPI/Sake.ipynb)|[国税庁の酒税の課税関係等状況表　過年分（4月～3月）](https://www.nta.go.jp/taxes/sake/tokei/kanen.htm)を使用して都道府県別酒消費量をグローバルに設定するサンプルコード|
||[大阪のアルコール消費量.csv](/src/jupyter-NativeAPI/大阪のアルコール消費量.csv)|大阪のアルコール消費量のCSV|
||[東京のアルコール消費量.csv](/src/jupyter-NativeAPI/東京のアルコール消費量.csv)|東京のアルコール消費量のCSV|
|[jupyter-pyODBC](/src/jupyter-pyODBC)||Jupyter用のpyODBCサンプルが含まれます|
||[HelloWorldPyODBC.ipynb](/src/jupyter-pyODBC/HelloWorldPyODBC.ipynb)|IRISへpyODBC経由でアクセスしてテーブル作成、データ登録、SELECTの例が含まれます|
||[train.csv](/src/jupyter-pyODBC/train.csv)|サンプルコードで使用しているTitanicの乗客情報です（Kaggleからダウンロードした情報を利用しています）。|
|[nativeAPI_wheel](/src/nativeAPI_wheel)||nativAPI用インストールファイルが含まれます。|
|[pyodbc_wheel](/src/pyodbc_wheel)||IRIS用ODBCドライバの設定用ファイルが含まれます。|
|[python-nativeAPI](/src/python-nativeAPI)||コンテナ上で実行できる NativeAPIを利用したPythonのサンプルコードが含まれるディレクトリです。|
||[HelloWorldNativeAPI.py](/src/python-nativeAPI/HelloWorldNativeAPI.py)|コンテナ上で実行できるNativeAPIのサンプルコード（IRISへの接続とグローバルの値設定、削除の簡単なサンプルコード）|
||[run.sh](/src/python-nativeAPI/run.sh)|NativeAPIのインストールと、サンプルコードで使用しているPythonライブラリのインストールも含めたシェル。（HelloWorldNativeAPI.pyとSake.pyを実行できます。）
||[Sake.py](/src/python-nativeAPI/Sake.py)|コンテナ上で実行できる[国税庁の酒税の課税関係等状況表　過年分（4月～3月）](https://www.nta.go.jp/taxes/sake/tokei/kanen.htm)を使用して都道府県別酒消費量をグローバルに設定するサンプルコード|
||[大阪のアルコール消費量.csv](/src/python-nativeAPI/大阪のアルコール消費量.csv)|大阪のアルコール消費量のCSV|
||[東京のアルコール消費量.csv](/src/python-nativeAPI/東京のアルコール消費量.csv)|東京のアルコール消費量のCSV|
|[python-pyODBC](/src/python-pyODBC)||コンテナ上で実行できるのpyODBCサンプルが含まれます|
||[HelloWorldPyODBC.py](/src/python-pyODBC/HelloWorldPyODBC.py)|コンテナ上で実行できるPyODBCのサンプルで、IRISへpyODBC経由でアクセスしてテーブル作成、データ登録、SELECTの例が含まれます|
||[train.csv](/src/python-pyODBC/train.csv)|サンプルコードで使用しているTitanicの乗客情報です（Kaggleからダウンロードした情報を利用しています）。|


## コンテナ起動までの手順
詳細は、[docker-compose.yml](./docker-compose.yml) をご参照ください。

Git展開後、**./ は コンテナ内 /irisdev/app ディレクトリをマウントしています。**
また、IRISの管理ポータルの起動に使用するWebサーバポートは 427773 が割り当てられています。

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

サンプルコード[HelloWorldPyODBC.py](/src/python-pyODBC/HelloWorldPyODBC.py)を実行します。
実行例は以下の通りです。
```
$ docker exec -it コンテナ名 bash
>cd /irisdev/app/src/python-pyODBC
>python3 HelloWorldPyODBC.py
```

