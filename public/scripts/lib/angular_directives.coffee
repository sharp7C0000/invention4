# Custom angular directive

define ['angular'], (angular) ->
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
			#require : '^ngClick'
			link: (scope, elem, attrs) ->
				console.log "inside link"
				element.on('load', ()-> console.log "load")
				element.on('click', ()-> console.log "ok")

				#elem.click = () -> console.log "click!"

		}


	)