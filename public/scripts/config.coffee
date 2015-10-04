# Shared require js config

require.config

	paths:
		angular                     : '../components/angular/angular'
		marked                      : '../components/marked/lib/marked'
		editor                      : '../components_other/editor/editor'
		directives                  : 'lib/angular_directives'
		globalMarked                : 'lib/marked'
		moment                      : '../components/moment/moment'
		highlightjs                 : '../components/highlightjs/highlight.pack'
		holderjs                    : '../components/holderjs/holder'
		social                      : '../components/angular-social-links/angular-social-links'
		socjs                       : '../components/socjs/soc.min'

	map:
	  '*':
	    'css': '../components/require-css/css'

	shim:
		angular               : {exports: 'angular'}
		editor                : {deps   : ['globalMarked', 'css!../css/editor']}
		highlightjs           : {deps   : ['css!../components/highlightjs/styles/arta']}
		social                : {deps   : ['angular']}
	
	priority: ["angular"]

# https://github.com/tnajdek/angular-requirejs-seed
# http://code.angularjs.org/1.3.0/docs/guide/bootstrap
# Should be lazy load angularjs
window.name = "NG_DEFER_BOOTSTRAP!"
