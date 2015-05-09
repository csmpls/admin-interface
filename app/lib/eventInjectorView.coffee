$ = require 'jquery'
_ = require 'lodash'
Bacon = require 'baconjs'
Bacon.$ = require 'bacon.jquery'
moment = require 'moment'
_baconmodel = require 'bacon.model'

injectEvent = require './injectEvent.coffee'

showEvent = ($div, eventData) ->
	$div.prepend(
		_.template('''
			<li><%= eventData.time %> - <%= eventData.eventName %> </li>
			''')(eventData:eventData))

setup = (timeDiffProp, eventserverURL, $input, $button, $injectedEvents) ->

	textInput = Bacon.$.textFieldValue($input)
	buttonClicks = $button.asEventStream('click')
	enterPresses = $input.asEventStream("keyup")
		.filter((e) -> return e.keyCode == 13)

	submitStream = buttonClicks.merge(enterPresses)

	timeDiff = Bacon.combineTemplate(timeDiff: timeDiffProp)

	# get server time on button click
	serverTime = timeDiff
		.sampledBy(buttonClicks)
		.map((d) -> return moment().utc().add(timeDiff).format())

	# make an object {eventName, time}
	eventData = Bacon.combineTemplate(
		eventName: textInput
		time: serverTime)

	# inject event on click
	eventData
		.sampledBy(submitStream)
		.onValue(injectEvent, eventserverURL)

	eventData
		.sampledBy(submitStream)
		.onValue(showEvent, $injectedEvents)

exports.setup = setup