# Base image
FROM ubuntu:22.04

# Set working directory argument
ARG SRCDIR="src"
ARG USERNAME="kenta"

# Set environment variables
ENV PATH="/home/${USERNAME}/.local/bin:${PATH}"
ENV PYTHONPATH="/usr/lib/python3/dist-packages:${PYTHONPATH}"
ENV TZ="Asia/Tokyo"

# Set timezone and install basic packages
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update && apt install -y tzdata python3 python3-pip curl unzip sudo git docker.io
RUN dpkg-reconfigure -f noninteractive tzdata

# Install git
RUN sudo apt install git

# Setup Node.js v18.x
RUN sudo apt remove nodejs npm
RUN curl -sL https://deb.nodesource.com/setup_18.x -o nodesource_setup.sh
RUN sudo bash nodesource_setup.sh
RUN sudo apt install nodejs

# Add user and allow it to use sudo without password
RUN useradd -m ${USERNAME} && echo "${USERNAME}:${USERNAME}" | chpasswd && adduser ${USERNAME} sudo && echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME}

# Add user to the 'docker' group
RUN groupadd docker
RUN usermod -aG docker ${USERNAME}

# Change user
USER ${USERNAME}

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | python3 -
RUN poetry config virtualenvs.create false

# Setup AWS CLI
USER root
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN sudo ./aws/install -i /usr/local/aws-cli -b /usr/local/bin

# Setup AWS CDK
RUN npm install -g aws-cdk

# Cleaning cache
RUN apt-get clean

# Create working directory
WORKDIR /home/${USERNAME}/${SRCDIR}

# Copy files with root user and then change owner to ${USERNAME}
USER root
COPY . .
RUN chown -R ${USERNAME}:${USERNAME} ./
USER ${USERNAME}
# Modify permissions to allow poetry installs
RUN sudo chmod -R o+w /usr/local/