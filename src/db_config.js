var Sequelize = require('sequelize')

module.exports = function() {
	  return new Sequelize('postgres://indra:shangr1la..@indra.webfactional.com:5432/indra_test')
}
