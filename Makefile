REGISTRY = 080385600816.dkr.ecr.us-east-1.amazonaws.com
TAG = 0.0.7
LOGIN:=$(shell aws ecr get-login --no-include-email)
PWD:=$(shell pwd)

build:
	dep ensure
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -ldflags="-s -w" -o oauth2-proxy
        
container:
	docker build -t oauth2-proxy:$(TAG) .

push: container
	exec ${LOGIN}
	docker tag oauth2-proxy:$(TAG) ${REGISTRY}/oauth2-proxy:$(TAG)
	docker push ${REGISTRY}/oauth2-proxy:$(TAG)
