# Custom angular directive

define ['angular', 'editor'], (angular, editor) ->
	angular.module('invention4.directives.editor', [])

	.directive('ngEditor', ($parse) ->
		{
			restrict: 'A'
			require : '?ngModel'
			scope: {
	    	ngModel: '='
	    }
			link: (scope, elem, attrs, ngModelCtrl) ->

				# initialize editor
				editor = new Editor()
				editor.render()
				
				setTimeout (() -> editor.codemirror.refresh()), 200

				# add on change listener
				editor.codemirror.on("change", () ->
					# update view value
					ngModelCtrl.$setViewValue(editor.codemirror.getValue())
				)
		}
	)