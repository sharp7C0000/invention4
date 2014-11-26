# Shared require js config

require.config
	paths: 
		angular                 : '../components/angular/angular'
		text                    : '../components/requirejs-text/text'
		'poly.core.header_panel': 'lib/polymer-component/core_header_panel'
		'poly.core.toolbar'     : 'lib/polymer-component/core_toolbar'
		'poly.paper.input'      : 'lib/polymer-component/paper_input'
		'poly.paper.button'     : 'lib/polymer-component/paper_button'
		'poly.paper.icon.button': 'lib/polymer-component/paper_icon_button'
		'ng-polymer-elements'   : '../components/ng-polymer-elements/ng-polymer-elements'
	shim:
		'angular'               : {'exports': 'angular'}

	priority: ["angular"]

# https://github.com/tnajdek/angular-requirejs-seed
# http://code.angularjs.org/1.3.0/docs/guide/bootstrap
# Should be lazy load angularjs
window.name = "NG_DEFER_BOOTSTRAP!"