# PythonのNativeAPIに挑戦／PythonからPyODBCを使ってInterSystems IRISに接続してみよう
このテンプレートは、InterSystems IRIS の Python 用 NativeAPIの接続を確認できるサンプルと
PyODBC で IRIS への接続を確認できるサンプルを含んだコンテナを提供しています。

## コミュニティに公開しているビデオのサンプルコードです。

(1) Python の NativeAPIに挑戦
https://jp.community.intersystems.com/post/%E3%80%90%E3%81%AF%E3%81%98%E3%82%81%E3%81%A6%E3%81%AE-intersystems-iris%E3%80%91%E3%82%BB%E3%83%AB%E3%83%95%E3%83%A9%E3%83%BC%E3%83%8B%E3%83%B3%E3%82%B0%E3%83%93%E3%83%87%E3%82%AA%EF%BC%9A%E3%82%A2%E3%82%AF%E3%82%BB%E3%82%B9%E7%B7%A8%EF%BC%9Apython-%E3%81%AE-nativeapi-%E3%81%AB%E6%8C%91%E6%88%A6

(2) Python の PyODBC を使って IRIS に接続してみよう
https://jp.community.intersystems.com/post/%E3%80%90%E3%81%AF%E3%81%98%E3%82%81%E3%81%A6%E3%81%AE-intersystems-iris%E3%80%91%E3%82%BB%E3%83%AB%E3%83%95%E3%83%A9%E3%83%BC%E3%83%8B%E3%83%B3%E3%82%B0%E3%83%93%E3%83%87%E3%82%AA%EF%BC%9A%E3%82%A2%E3%82%AF%E3%82%BB%E3%82%B9%E7%B7%A8%EF%BC%9Apython-%E3%81%8B%E3%82%89-pyodbc-%E3%82%92%E4%BD%BF%E3%81%A3%E3%81%A6-iris-%E3%81%AB%E6%8E%A5%E7%B6%9A%E3%81%97%E3%81%A6%E3%81%BF%E3%82%88%E3%81%86


## コードの動かし方

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

## (1) NativeAPIを体験する
コンテナでは、Pythonのインストールも一緒に行っています。
コンテナにログイン後、run.sh を実行すると、 NativeAPIのインポートと必要なPythonライブラリのインポートを実施し、
/src/python-nativeAPI/HelloWorldNativeAPI.py
/src/python-nativeAPI/Sake.py
を実行します。
実行例は以下の通りです。
```
$ docker exec -it コンテナ名 bash
>cd /irisdev/app/src/python-NativeAPI
>./run.sh
```
Sake.py実行後、4種類のグラフの画像をカレントディレクトリに作成します。

Jupyterで実行を確認される場合は、
/src/jupyter-NativeAPI　以下ファイルをご利用ください。


## PyODBCを体験する。
IRISのODBCドライバをインストールするため odbcinst を実行します。
このコマンドは、root権限が必要なため、一旦rootに切り替えて以下実行します。
なお、rootのパスワードは　root です。
インストールも含めたrun.shを用意しています。run.shの中では、
/src/python-pyodbc/HelloWorldPyODBC.py
を実行します。
実行例は以下の通りです。
```
$ docker exec -it コンテナ名 bash
>su -
> rootのパスワードを入力
>cd /irisdev/app/src/python-pyODBC
>./run.sh
```

Jupyterで実行を確認される場合は、
/src/jupyter-pyODBC　以下ファイルをご利用ください。

