$ = require('jquery')
io = require 'socket.io-client'
Bacon = require 'baconjs'

onlineUsersView = require './lib/OnlineUsersView.coffee'

init = ->

	# config
	socketURL = 'localhost:3333'
	$userlistDiv = $("#userlist")

	socket = io(socketURL)

	# draw userlists to the dom
	Bacon.fromEvent(socket, 'userlist')
		.onValue((list) -> 
			onlineUsersView.setup($userlistDiv, list))

	console.log 'main app done+launched'

# launch the app
$(document).ready(() ->
	init() )
