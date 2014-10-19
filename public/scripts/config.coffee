# Shared require js config

require.config
	paths: 
		angular: '../components/angular/angular'
	shim:
		'angular': {'exports': 'angular'}
	priority: ["angular"]

# https://github.com/tnajdek/angular-requirejs-seed
# http://code.angularjs.org/1.3.0/docs/guide/bootstrap
# Should be lazy load angularjs
window.name = "NG_DEFER_BOOTSTRAP!"