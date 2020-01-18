setup:
	docker-compose build

yarn:
	docker-compose run app yarn install

run: yarn
	docker-compose up

clean:
	docker-compose down --rmi all --volumes
