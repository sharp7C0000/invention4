# Shared require js config

require.config
	paths: 
		angular                 : '../components/angular/angular'
		text                    : '../components/requirejs-text/text'
		'poly.core.header_panel': 'lib/polymer-component/core_header_panel'
		'poly.core.toolbar'     : 'lib/polymer-component/core_toolbar'
	shim:
		'angular'               : {'exports': 'angular'}
		layout                  : {'deps': [
			'poly.core.header_panel'
			'poly.core.toolbar'
		]}

	priority: ["angular"]

# https://github.com/tnajdek/angular-requirejs-seed
# http://code.angularjs.org/1.3.0/docs/guide/bootstrap
# Should be lazy load angularjs
window.name = "NG_DEFER_BOOTSTRAP!"