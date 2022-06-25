package main

import (
	"database/sql"
	"log"

	"github.com/andiahmads/simple-bank/api"
	db "github.com/andiahmads/simple-bank/db/sqlc"
	"github.com/andiahmads/simple-bank/util"
	_ "github.com/lib/pq"
)

func main() {
	// call env config with viper
	config, err := util.LoadConfig(".")
	if err != nil {
		log.Fatal("cannot load Confing:", err)
	}

	conn, err := sql.Open(config.DBDriver, config.DBSource)
	if err != nil {
		log.Fatalf("cannot connect to database:%v", err)
	}

	store := db.NewStore(conn)
	server, err := api.NewServer(config, store)
	if err != nil {
		log.Fatalf("cannot create server:%v", err)
	}

	err = server.Start(config.ServerAddress)
	if err != nil {
		log.Fatalf("cannot start server:%v", err)
	}
}
