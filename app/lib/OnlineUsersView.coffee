$ = require 'jquery'
Bacon = require 'baconjs'
_ = require 'lodash'

userView = (user) ->
	_.template('''
		<li>
			<% if (user.signalQuality == 0) { %>
				<span class = "signalStatus goodSignal">[x]</span>
			<% } else { %>
				<span class = "signalStatus badSignal">[ ]</span>
			<% } %>
			<%= user.id %>
		</li>
		''')(user:user)

exports.setup = ($div, userlist) ->
	$div.empty()
	_.forEach(
		_.sortBy(userlist, 'id')
		, (user) -> 
			$div.append(userView(user)))
