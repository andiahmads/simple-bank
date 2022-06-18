package db

import (
	"database/sql"
	"log"
	"os"
	"testing"

	"github.com/andiahmads/simple-bank/util"
	_ "github.com/lib/pq"
)

var testQueries *Queries
var testDb *sql.DB

func TestMain(m *testing.M) {
	config, err := util.LoadConfig("../..")
	if err != nil {
		log.Fatal("cannot load Confing:", err)
	}
	testDb, err = sql.Open(config.DBDriver, config.DBSource)
	if err != nil {
		log.Fatalf("cannot connect to database:%v", err)
	}

	testQueries = New(testDb)
	os.Exit(m.Run())

}
