# Custom angular directive

define ['angular', 'editor'], (angular, editor) ->
	angular.module('invention4.directives', [])

	.directive('test', () ->
		{
			restrict: 'A'
			require: '^ngModel'
			scope: { ngCity: '@' }
			template: '<div class="sparkline"><h4>Weather for {{ngModel}}</h4></div>'
		}
	)

	.directive('paper-fab', () ->
		{
			restrict:'E'
			link: (scope, elem, attrs) ->
				elem.on('load', ()-> console.log "load")
				elem.on('click', ()-> console.log "ok")
		}
	)