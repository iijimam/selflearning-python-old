ARG IMAGE=intersystems/iris:2019.1.0S.111.0
ARG IMAGE=store/intersystems/irishealth:2019.3.0.308.0-community
ARG IMAGE=store/intersystems/iris-community:2019.3.0.309.0
ARG IMAGE=store/intersystems/iris-community:2019.4.0.379.0
ARG IMAGE=store/intersystems/iris-community:2020.1.0.197.0
ARG IMAGE=intersystemsdc/iris-community:2020.1.0.209.0-zpm
ARG IMAGE=intersystemsdc/iris-community:2020.1.0.215.0-zpm
ARG IMAGE=intersystemsdc/iris-community:2020.2.0.196.0-zpm
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
ARG username=hoge
ARG wkdir=/home/work
RUN echo "root:root" | chpasswd && \
    adduser --disabled-password --gecos "" "${username}" && \
    echo "${username}:${username}" | chpasswd && \
    echo "%${username}    ALL=(ALL)   NOPASSWD:    ALL" >> /etc/sudoers.d/${username} && \
    chmod 0440 /etc/sudoers.d/${username} 
WORKDIR ${wkdir}
RUN chown ${username}:${username} ${wkdir}

RUN apt-get install -y vim less
RUN apt-get -y install python3 python3-pip
RUN pip3 install --upgrade setuptools

#pyodbcインスール
RUN apt-cache search iodbc
RUN apt-get install -y unixodbc-dev iodbc
RUN pip3 install --upgrade --global-option=build_ext --global-option="-I/usr/local/include" --global-option="-L/usr/local/lib" pyodbc

# Matplotlib 用の設定ファイルを用意する。
#WORKDIR /etc
#RUN echo "backend : Agg" >> matplotlibrc \
# && echo "font.family : Ricty Diminished" >> matplotlibrc

# Matplotlib をインストールする。
#WORKDIR /opt/app
#ENV MATPLOTLIB_VERSION 2.0.2
#RUN pip3 install matplotlib==$MATPLOTLIB_VERSION

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
