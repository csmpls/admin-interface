$ = require('jquery')
io = require 'socket.io-client'
Bacon = require 'baconjs'
sank = require 'sank'

onlineUsersView = require './lib/OnlineUsersView.coffee'
eventInjectorView = require './lib/eventInjectorView.coffee'

init = ->

	# config
	socketURL = 'localhost:3333'
	timeserverURL = 'http://indra.webfactional.com/timeserver'
	eventserverURL = 'http://indra.webfactional.com/eventserver'
	timeserverUpdateInterval = 5000
	# ui bits
	$userlistDiv = $("#userlist")
	$injectEventButton = $('#injectEventButton')
	$eventInput = $('#eventInput')
	$injectedEventsDiv = $('#eventsInjected')

	socket = io(socketURL)

	# receive userlists and draw on the dom
	Bacon.fromEvent(socket, 'userlist')
		.onValue((list) -> 
			onlineUsersView.setup($userlistDiv, list))

	# setup the event injector
	eventInjectorView.setup(
		sank(timeserverURL, timeserverUpdateInterval)
		, eventserverURL
		, $eventInput
		, $injectEventButton
		, $injectedEventsDiv)

	console.log 'main app done+launched'

# launch the app
$(document).ready(() ->
	init() )
