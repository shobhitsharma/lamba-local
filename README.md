# lambda-local
A generic AWS Lambda function for base start.

## Development

#### Prerequisites
- [Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/installing.html)
- [Install AWS SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html)
- [Install Docker](https://docs.docker.com/docker-for-mac/install)
- [Go Dependency Management](https://github.com/golang/dep)

### Run

For production replication lambda environment:

```bash
# Run API Gateway using SAM handler attached to docker network
$ make lambda

# Local Lambda invocation
$ make lambda-invoke
```

For offline test cases using [localstack](https://github.com/localstack/localstack):

```bash
# Create Docker Bridge for local AWS Stack
$ docker network create -d bridge sam-localstack

# Spin up docker image for localstack
$ docker-compose up -d

# [OR] To intercept TCP connections for SES (optional: --env-vars ENV.json)
$ sam local start-api --docker-network $(docker network inspect --format='{{.Id}}' sam-localstack)

# Commit dependencies with `dep` (see prerequsites)
$ dep ensure
```

### Test

```bash
$ docker-compose up -d
$ make test
```

#### Resources
* [SES API Reference](https://docs.aws.amazon.com/sdk-for-go/api/service/ses/)
* [Lambda API Reference](https://docs.aws.amazon.com/sdk-for-go/api/service/lambda/)
* [Request SES Production Access](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/request-production-access.html)
* [Go support for AWS Lambda](https://aws.amazon.com/blogs/compute/announcing-go-support-for-aws-lambda/)