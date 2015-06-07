define [], () ->
	Polymer.import ["/components/paper-tabs/paper-tabs.html"], (() ->
		# activate tab
		setTimeout (() ->
			tabs = document.querySelector('paper-tabs')
			tabs.updateBar() if tabs?
		), 100
	).bind(this)
