.PHONY: up down restart logs migrate-up migrate-down migrate-create

up:
	docker compose up -d

down:
	docker compose down

restart:
	docker compose down
	docker compose up -d

logs:
	docker compose logs -f

migrate-up:
	docker run --rm \
	  --network container:osmity-postgres-local \
	  -v $(PWD)/../osmity-web-backend/migrations:/migrations \
	  migrate/migrate \
	  -path /migrations \
	  -database "postgres://osmity:osmity_dev_password@localhost:5432/osmity_dev?sslmode=disable" up

migrate-down:
	docker run --rm \
	  --network container:osmity-postgres-local \
	  -v $(PWD)/../osmity-web-backend/migrations:/migrations \
	  migrate/migrate \
	  -path /migrations \
	  -database "postgres://osmity:osmity_dev_password@localhost:5432/osmity_dev?sslmode=disable" down 1

migrate-create:
	migrate create -ext sql -dir ../osmity-web-backend/migrations -seq $(name)