# Shared require js config

require.config
	paths: 
		angular                 : '../components/angular/angular'
		text                    : '../components/requirejs-text/text'
		'poly.core.header_panel': 'lib/polymer-component/core_header_panel'
		'poly.core.toolbar'     : 'lib/polymer-component/core_toolbar'
		'poly.paper.input'      : 'lib/polymer-component/paper_input'
		'poly.grid'             : 'lib/polymer-component/grid_layout'
	shim:
		'angular'               : {'exports': 'angular'}
		layout                  : {'deps': [
			'poly.core.header_panel'
			'poly.core.toolbar'
			'poly.paper.input'
			'poly.grid'
		]}

	priority: ["angular"]

# https://github.com/tnajdek/angular-requirejs-seed
# http://code.angularjs.org/1.3.0/docs/guide/bootstrap
# Should be lazy load angularjs
window.name = "NG_DEFER_BOOTSTRAP!"