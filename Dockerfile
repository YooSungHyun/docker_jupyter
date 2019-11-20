FROM python:3.7.5
MAINTAINER 32283@kyowon.co.kr

ENV PYTHONUNBUFFERED 1

RUN apt-get update -y
RUN apt-get --assume-yes install freetds-dev freetds-bin python-dev python-pip openjdk-11-jdk

RUN apt-get upgrade -y

ADD requirements.txt /home/docker-container/jupyter_notebook/
RUN pip install -r /home/docker-container/jupyter_notebook/requirements.txt

RUN pip install "pymssql<3.0"

RUN pip install jupyter
ADD config/jupyter/jupyter_notebook_config.py /root/.jupyter/
RUN mkdir /root/.jupyter/custom
RUN echo '.CodeMirror pre {font-family: Inconsolata-g; font-size: 12pt; line-height: 140%;}\n.container { width:100% !important; }\ndiv.output pre{\n    font-family: Inconsolata-g;\n    font-size: 12pt;\n}' >> /root/.jupyter/custom/custom.css

WORKDIR /home/docker-container/jupyter_notebook