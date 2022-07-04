postgres:
	docker run --name postgres12 --network bank-network -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine

createdb:
	docker exec -it postgres12 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres12 dropdb simple_bank

migrateup:
	migrate --path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up 

aws-migrateup:
	migrate --path db/migration -database "postgresql://root:V27NOI!LE&Hf9@simple-bank.cwkc7me9fnj5.ap-southeast-3.rds.amazonaws.com:5432/simple_bank" -verbose up 


migrateup1:
	migrate --path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up 1 


migratedown:
	migrate --path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down 

migratedown1:
	migrate --path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down 1


sqlc:
	sqlc generate

test: 
	go test -v -cover ./...

server:
	go run main.go

mock: 
	mockgen -destination db/mock/store.go github.com/andiahmads/simple-bank/db/sqlc Store

generate-migrate-user:
	migrate create -ext sql -dir db/migration -seq add_users

.PHONY: postgres createdb dropdb migrateup migratedown migrateup1 migratedown1 sqlc test server mock migrate-user aws-migrateup

