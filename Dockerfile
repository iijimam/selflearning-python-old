#イメージのタグはこちら（https://hub.docker.com/_/intersystems-iris-data-platform）でご確認ください
ARG IMAGE=store/intersystems/iris-community:2020.2.0.204.0
ARG IMAGE=store/intersystems/iris-community:2020.1.0.215.0
FROM $IMAGE

USER root

###########################################
##### Install Python

RUN apt-get update
RUN apt-get -y install locales && \
    localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
ENV TZ JST-9
ENV TERM xterm

RUN apt-get install -y vim less
RUN apt-get -y install python3 python3-pip
RUN pip3 install --upgrade setuptools

# IRIS odbcドライバのインストール
COPY src/pyodbc_wheel/linux .
#pyodbcインスール
RUN apt-cache search iodbc
RUN apt-get install -y unixodbc-dev iodbc
RUN pip3 install --upgrade --global-option=build_ext --global-option="-I/usr/local/include" --global-option="-L/usr/local/lib" pyodbc
RUN odbcinst -i -d -f odbcinst.ini
RUN odbcinst -i -s -l -f odbcinst.ini \
 && mv $ISC_PACKAGE_INSTALLDIR/mgr/irisodbc.ini $ISC_PACKAGE_INSTALLDIR/mgr/irisodbc.ini.org \
 && cp odbcinst.ini $ISC_PACKAGE_INSTALLDIR/mgr/irisodbc.ini \
 && cd $ISC_PACKAGE_INSTALLDIR/bin \
 && mv odbcgateway.so odbcgateway.so.org \
 && cp odbcgatewayur64.so odbcgateway.so\
 && mv liblber-2.4.so.2 liblber-2.4.so.2.org \
 && mv libldap-2.4.so.2 libldap-2.4.so.2.org \
 && ln -s /usr/lib/x86_64-linux-gnu/liblber-2.4.so.2 liblber-2.4.so.2 \
 && ln -s /usr/lib/x86_64-linux-gnu/libldap-2.4.so.2 libldap-2.4.so.2 


# pandas インストール
RUN pip3 install pandas


WORKDIR /opt/irisapp
RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/irisapp

COPY  --chown=irisowner irissession.sh /
RUN chmod +x /irissession.sh 

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
