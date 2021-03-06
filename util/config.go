package util

import (
	"time"

	"github.com/spf13/viper"
)

// Config menyimpan semua konfigurasi aplikasi
// Nilai dibaca oleh Viper dari file konfigurasi atau variabel lingkungan.
type Config struct {
	DBDriver            string        `mapstructure:"DB_DRIVER"`
	DBSource            string        `mapstructure:"DB_SOURCE"`
	ServerAddress       string        `mapstructure:"SERVER_ADDRESS"`
	TokenSymmetricKey   string        `mapstructure:"TOKEN_SYMMETRIC_KEY"`
	AccessTokenDUration time.Duration `mapstructure:"ACCESS_TOKEN_DURATION"`
}

// loadConfing reads configuration from file environment variable.
func LoadConfig(path string) (config Config, err error) {
	viper.AddConfigPath(path)
	viper.SetConfigName("app")
	viper.SetConfigType("env")

	viper.AutomaticEnv()

	err = viper.ReadInConfig()
	if err != nil {
		return
	}
	err = viper.Unmarshal(&config)
	return
}
