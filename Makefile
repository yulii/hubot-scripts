.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

setup:  ## Build docker images
	docker-compose build

yarn: setup  ## Install dependencies
	docker-compose run app yarn install

yarn-outdated:
	docker-compose run app yarn outdated

test: yarn
	docker-compose run app yarn test
	docker-compose run app yarn lint

run: yarn  ## Start up applications
	docker-compose up

clean:  ## Remove all images and volumes
	rm -r node_modules
	docker-compose down --rmi all --volumes
