# Shared require js config

require.config
	paths: 
		angular: '../components/angular/angular'
		polymer: '../components/polymer/polymer'
	shim:
		'angular': {'exports': 'angular'}
		'polymer': {'exports': 'polymer'}
	priority: ["angular", "polymer"]

# https://github.com/tnajdek/angular-requirejs-seed
# http://code.angularjs.org/1.3.0/docs/guide/bootstrap
# Should be lazy load angularjs
window.name = "NG_DEFER_BOOTSTRAP!"