# cdk-env Readme
This Dockerfile provides the instructions for building a Docker image with a specific environment. Below is a description of each step in the Dockerfile and how to use it:

## Base Image
The Docker image is based on Ubuntu 22.04, which serves as the foundation for the environment.

## Environment Variables
The following environment variables are set within the image:

- PATH: Appends /root/.local/bin to the existing PATH variable.
- PYTHONPATH: Appends /usr/lib/python3.10/site-packages to the existing PYTHONPATH variable.
- TZ: Sets the timezone to Asia/Tokyo.
## Timezone Configuration
The Docker image sets the timezone to Asia/Tokyo by creating a symbolic link to the corresponding zoneinfo file and updating the timezone configuration file.

## System Packages Installation
The image updates the package lists and installs the following packages using apt:

- tzdata: Timezone data package.
- python3: Python 3 interpreter.
- python3-pip: Python package installer.
- curl: Command-line tool for making HTTP requests.
- unzip: Utility for extracting ZIP archives.
- nodejs: JavaScript runtime environment.
- npm: Package manager for Node.js.
## Timezone Configuration (Noninteractive)
The Docker image reconfigures the timezone data package (tzdata) in a noninteractive mode to avoid user prompts during the build process.

## Cleaning Up
The apt-get clean command is used to remove any unnecessary files and clean the package cache to reduce the image size.

## Python Poetry Installation
The image downloads and installs Poetry, a dependency management and packaging tool for Python projects, using the curl command.

## Poetry Configuration
The image configures Poetry to disable the automatic creation of virtual environments using the poetry config command.

## AWS CLI Installation
The image downloads the AWS CLI version 2 package from the official source, extracts it, and installs it in the /usr/local/aws-cli directory.

## AWS CDK Installation
The image installs the AWS Cloud Development Kit (CDK) globally using the npm command.

## Application Setup
The image creates a directory at /var/src and copies the contents of the current directory (where the Dockerfile resides) into the /var/src directory of the image. It then sets the working directory to /var/src, which will be the default location for executing commands and running the application.

## Usage
To use this Docker image, follow these steps:

1. Clone this repository using the following command:

```bash
git clone <repository-url>
```
Replace <repository-url> with the URL of the repository where the Dockerfile is located.

2. Change into the aws-cdk-dev-env directory:

```bash
cd aws-cdk-dev-env
```

3. Create a .secret file at the root directory with the following content:

```.secret
AWS_DEFAULT_REGION=ap-northeast-1
AWS_ACCESS_KEY_ID=your-key
AWS_SECRET_ACCESS_KEY=your-secret-key
AWS_DEFAULT_OUTPUT=json
AWS_ACCOUNT_NUMBER=your-account-number
```
Replace your-key, your-secret-key, and your-account-number with your actual AWS credentials and account number.

4. Build and start the Docker containers using docker-compose:

```bash
docker-compose up -d
```
5. Check the container ID of the running container using docker ps command.

6. Enter the container's shell by running the following command, replacing container-id with the actual container ID obtained in the previous step:

```bash
docker exec -it container-id /bin/bash
```
7. Set up your source code by placing it in the ./src directory within the container.

Note: Make sure you have Docker and Docker Compose installed and properly configured on your system before running the above commands.

Please refer to the Docker documentation for more information on building and running Docker images and containers.
