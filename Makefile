setup:
	docker-compose build

yarn:
	docker-compose run app yarn install

test: yarn
	docker-compose run app yarn test
	docker-compose run app yarn lint

run: yarn
	docker-compose up

clean:
	rm -r node_modules
	docker-compose down --rmi all --volumes
