FROM ubuntu:22.04

ARG SRCDIR="/var/src"

ENV PATH="/root/.local/bin:${PATH}"
ENV PYTHONPATH="/usr/lib/python3.10/site-packages:${PYTHONPATH}"
ENV TZ="Asia/Tokyo"

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update && apt install -y tzdata python3 python3-pip curl unzip nodejs npm
RUN dpkg-reconfigure -f noninteractive tzdata
RUN apt-get clean

RUN curl -sSL https://install.python-poetry.org | python3 -
RUN poetry config virtualenvs.create false

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install -i /usr/local/aws-cli -b /usr/local/bin

RUN npm install -g aws-cdk

RUN mkdir -p /var/src
COPY . /var/src
WORKDIR /var/src