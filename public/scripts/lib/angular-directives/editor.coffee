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

				updateValue = (value) -> ngModelCtrl.$setViewValue(value)

				# initialize editor
				editor = new Editor()
				editor.render()

				# update view value
				updateValue(editor.codemirror.getValue())
				
				# add on change listener
				editor.codemirror.on("change", () ->
					# update view value
					updateValue(editor.codemirror.getValue())
				)

				setTimeout (() ->
					editor.codemirror.refresh()
					editor.codemirror.focus()
				), 500
		}
	)