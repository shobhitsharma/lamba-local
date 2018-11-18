
PROJECT_NAME=la-omq-api
VERSION=0.1
HASH=$(shell git rev-parse --short HEAD)
BINPATH=./bin
FUNCTION=func/mailer

# Get git-hash version
.PHONY: getver
getver:
	@echo $(VERSION)-$(HASH)

# Generate bin
.PHONY: bin
bin:
	@echo "> Building lambda distribution ..."
	GOARCH=amd64 GOOS=linux CGO_ENABLED=0 go build -o $(BINPATH)/main func/mailer.go

# Run tests
.PHONY: test
test:
	@go test -v ./...

# Cleans up previous builds
.PHONY: clean
clean:
	@echo "> Cleaning previous builds"
	@rm -rf bin
	@mkdir -p bin
	@go clean

# Run local API Gateway
.PHONY: lambda
lambda:
	@echo "> Running local lambda API ..."
	sam local start-api --debug

# Invoke local lambda
.PHONY: lambda-invoke
lambda-invoke:
	sam local invoke $(FUNCTION) -e ./test/event.json

# Run local lambda
.PHONY: lambda-fmt
lambda-test:
	sam local start-lambda

# Builds ideal distribution
.PHONY: build
build: clean bin
	chmod +x $(BINPATH)/*
	cd $(BINPATH) && zip mailer.zip main
	@echo "> Lamda build files are available in $(BINPATH)"