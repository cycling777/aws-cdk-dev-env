FROM ubuntu:22.04
# set working dir
ARG SRCDIR="/var/src"
# setup environment variables
ENV PATH="/root/.local/bin:${PATH}"
ENV PYTHONPATH="/usr/lib/python3.11/site-packages:${PYTHONPATH}"
ENV TZ="Asia/Tokyo"
# setup python3.11.x
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update && apt install -y tzdata python3 python3-pip curl unzip sudo git
RUN dpkg-reconfigure -f noninteractive tzdata
# setup git
RUN sudo apt install git
# setup nodejs ver18.x
RUN sudo apt remove nodejs npm
RUN curl -sL https://deb.nodesource.com/setup_18.x -o nodesource_setup.sh
RUN sudo bash nodesource_setup.sh
RUN sudo apt install nodejs
# setup poetry
RUN curl -sSL https://install.python-poetry.org | python3 -
RUN poetry config virtualenvs.create false
# setup aws-cli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install -i /usr/local/aws-cli -b /usr/local/bin
# setup aws-cdk
RUN npm install -g aws-cdk
#cleaning cache
RUN apt-get clean

RUN mkdir -p ${SRCDIR}
COPY . ${SRCDIR}
WORKDIR ${SRCDIR}