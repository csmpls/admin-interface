express = require "express"
app = express()
server = require('http').Server(app);
io = require('socket.io')(server);
getSince = require 'sequelize-getsince'
NeuroskySeqeuelizeModel = require 'sequelize-neurosky'
getPastTime = require './src/getPastTime.coffee'
findConnectedUsers = require './src/findConnectedUsers.coffee'
connectToIndraDatabase = require('./src/db_config.js')

# config
port = 3333 
secondsAgoToLook = 2
updateInterval = 3000
publicDir = "#{__dirname}/built-app"

# our db
indraDatabase = connectToIndraDatabase()
NeuroskyReading = NeuroskySeqeuelizeModel.define(indraDatabase)

# global var to store our last queried userlist
connectedUsers = null

# serve webapp
app.use(express.static(publicDir))
app.get("/", (req, res) ->
	res.sendFile(
		path.join(publicDir, 'index.html')))

# manage socket connections
io.on('connection', (socket) ->
	socket.emit('userlist', connectedUsers))

handleResults = (data) ->
	connectedUsers = findConnectedUsers(data)
	io.emit('userlist', connectedUsers)

interval = (time, cb) -> setInterval(cb, time)
interval(updateInterval, () -> 
	getSince(
		getPastTime(5)
		, NeuroskyReading
		, (data) ->
			handleResults(data)
		, (error) ->
			console.log 'oh no!', error))


server.listen(port)
console.log 'server listening on ' + port
