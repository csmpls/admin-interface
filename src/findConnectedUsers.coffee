_ = require 'lodash'

latestSignalQuality = (userId, allUsers) ->
	_.result(
		_.findLast(allUsers, {id:userId})
		, 'signal_quality' )

# returns a list of objects [{id, signal_quality}]
findConnectedUsers = (data) ->

	# get all entries
	entries = _.map(data, 'dataValues')

	# get unique ids 
	ids = _.map(entries, 'id')
	uniqueIds = _.unique(ids)

	# get an object {id, signal_quality}
	connectedUsers = _.map(uniqueIds, (userId) ->
		return {
			id: userId
			signalQuality: latestSignalQuality(userId, entries)
		})

	connectedUsers

module.exports = findConnectedUsers