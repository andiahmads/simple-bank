package api

import (
	"github.com/andiahmads/simple-bank/util"
	"github.com/go-playground/validator/v10"
)

var validCurrency validator.Func = func(fieldLevel validator.FieldLevel) bool {
	if currency,ok := fieldLevel.Field().Interface().(string); ok {
		// check apakah mata uang support
		return util.IsSupportedCurrency(currency)

	}
	return false
}