moment = require 'moment'

getTimeInPast = (secondsAgo) ->
	return moment().subtract(secondsAgo, 'seconds')

module.exports = getTimeInPast