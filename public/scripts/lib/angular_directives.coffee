# Custom angular directive

define ['angular'], (angular) ->
	angular.module('invention4.directives', [])

	.directive('paper-fab', () ->
		{
			restrict:'E'
			link: (scope, elem, attrs) ->
				elem.on('load', ()-> console.log "load")
				elem.on('click', ()-> console.log "ok")
		}
	)
