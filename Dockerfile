#イメージのタグはこちら（https://hub.docker.com/_/intersystems-iris-data-platform）でご確認ください
ARG IMAGE=store/intersystems/iris-community:2020.2.0.204.0
ARG IMAGE=store/intersystems/iris-community:2020.1.0.215.0
FROM $IMAGE

USER root

WORKDIR /opt/irisapp
RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/irisapp

COPY  --chown=irisowner irissession.sh /
RUN chmod +x /irissession.sh 

###########################################
##### Install Python
USER root

RUN apt-get update
RUN apt-get -y install locales && \
    localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
ENV TZ JST-9
ENV TERM xterm

# sudo コマンド
RUN apt-get install -y sudo
# rootにパスワードを設定する（root）
RUN echo "root:root" | chpasswd

RUN apt-get install -y vim less
RUN apt-get -y install python3 python3-pip
RUN pip3 install --upgrade setuptools

#pyodbcインスール
RUN apt-cache search iodbc
RUN apt-get install -y unixodbc-dev iodbc
RUN pip3 install --upgrade --global-option=build_ext --global-option="-I/usr/local/include" --global-option="-L/usr/local/lib" pyodbc

# pandas インストール
RUN pip3 install pandas


WORKDIR /opt/irisapp

###########################################
#### Set up the irisowner account and load application
USER irisowner

COPY  --chown=irisowner Installer.cls .
COPY  --chown=irisowner src src

# Configure this demo IRIS instance
SHELL ["/irissession.sh"]

# Set up anything you may need in Objectscript
RUN \
  Do ##class(Config.NLS.Locales).Install("jpuw") \
  Do ##class(Security.Users).UnExpireUserPasswords("*")  \
  do $SYSTEM.OBJ.Load("Installer.cls", "ck") \
  set sc = ##class(App.Installer).setup() 

ENV PATH="/usr/irissys/bin/:${PATH}"

# bringing the standard shell back
SHELL ["/bin/bash", "-c"]
