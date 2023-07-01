# README

## Usage
- `git clone this repo`
- `cd aws-cdk-dev-env`
- make .secret at root directory like bellow

```
AWS_DEFAULT_REGION=ap-northeast-1
AWS_ACCESS_KEY_ID=your-key
AWS_SECRET_ACCESS_KEY=your-secret-key
AWS_DEFAULT_OUTPUT=json
AWS_ACCOUNT_NUMBER=your-account-number
```

- `docker-compose up -d`
- `docker ps` and check the contained-id
- `docker exec -it container-id /bin/bash`
- set your source code at ./src
