DOCKER_VERSION := $(shell docker --version 2>/dev/null)
DOCKER_COMPOSE_VERSION := $(shell docker-compose --version 2>/dev/null)

ENV_BROWSER_HYDRA_HOST ?= localhost
ENV_BROWSER_CONSUMER_HOST ?= localhost
ENV_BROWSER_IDP_HOST ?= localhost
ENV_BROWSER_OATHKEEPER_PROXY_HOST ?= localhost
ENV_RESOURCE_SERVER_HOST ?= localhost
ENV_KETO_SERVER_HOST ?=localhost

ENV_HYDRA_VERSION ?= v1.0.0-rc.5_oryOS.10
ENV_KETO_VERSION ?=  latest
                     #v0.3.3-sandbox
                     #v0.2.2-sandbox_oryOS.10
ENV_OATHKEEPER_VESRION ?= v0.15.2
							 #v0.16.0-beta.4
							 #v0.14.2_oryOS.10
ENV_LOGIN_CONSENT_VERSION ?= v1.0.0-rc.5

all:
ifndef DOCKER_VERSION
    $(error "command docker is not available, please install Docker")
endif
ifndef DOCKER_COMPOSE_VERSION
    $(error "command docker-compose is not available, please install Docker")
endif

export LOGIN_CONSENT_VERSION=${ENV_LOGIN_CONSENT_VERSION}
export HYDRA_VERSION=${ENV_HYDRA_VERSION}
export OATHKEEPER_VERSION=${ENV_OATHKEEPER_VESRION}
export KETO_VERSION=${ENV_KETO_VERSION}

export BROWSER_HYDRA_HOST=${ENV_BROWSER_HYDRA_HOST}
export BROWSER_CONSUMER_HOST=${ENV_BROWSER_CONSUMER_HOST}
export BROWSER_IDP_HOST=${ENV_BROWSER_IDP_HOST}
export BROWSER_OATHKEEPER_PROXY_HOST=${ENV_BROWSER_OATHKEEPER_PROXY_HOST}
export BROWSER_RESOURCE_HOST=${ENV_RESOURCE_SERVER_HOST}
export BROWSER_KETO_HOST=${ENV_KETO_SERVER_HOST}

build-dev:
		docker build -t oryd/hydra:dev ${GOPATH}/src/github.com/ory/hydra/
		docker build -t oryd/oathkeeper:dev ${GOPATH}/src/github.com/ory/oathkeeper/
		docker build -t oryd/keto:dev ${GOPATH}/src/github.com/ory/keto/

###

start-full-stack:
		cd full-stack; docker-compose up --build -d

restart-full-stack:
		cd full-stack; docker-compose restart

rm-full-stack:
		cd full-stack; docker-compose kill
		cd full-stack; docker-compose rm -f

reset-full-stack: rm-full-stack start-full-stack
