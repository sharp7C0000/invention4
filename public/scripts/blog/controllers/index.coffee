# Sample index controller

define [], () -> [ "$scope", "$http", "$window", ($scope, $http, $window) ->

	$scope.summaryOri = angular.copy($scope.summary)

	# substring by byte
  # http://stackoverflow.com/questions/11200451/extract-substring-by-utf-8-byte-positions
	subStrByByte = (str, start, length) ->

		encode_utf8 = (s) -> unescape encodeURIComponent(s)

		substr_utf8_bytes = (str, startInBytes, lengthInBytes) ->

		  ### this function scans a multibyte string and returns a substring.
		  # arguments are start position and length, both defined in bytes.
		  #
		  # this is tricky, because javascript only allows character level
		  # and not byte level access on strings. Also, all strings are stored
		  # in utf-16 internally - so we need to convert characters to utf-8
		  # to detect their length in utf-8 encoding.
		  #
		  # the startInBytes and lengthInBytes parameters are based on byte
		  # positions in a utf-8 encoded string.
		  # in utf-8, for example:
		  #       "a" is 1 byte,
		           "ü" is 2 byte,
		      and  "你" is 3 byte.
		  #
		  # NOTE:
		  # according to ECMAScript 262 all strings are stored as a sequence
		  # of 16-bit characters. so we need a encode_utf8() function to safely
		  # detect the length our character would have in a utf8 representation.
		  #
		  # http://www.ecma-international.org/publications/files/ecma-st/ECMA-262.pdf
		  # see "4.3.16 String Value":
		  # > Although each value usually represents a single 16-bit unit of
		  # > UTF-16 text, the language does not place any restrictions or
		  # > requirements on the values except that they be 16-bit unsigned
		  # > integers.
		  ###

		  resultStr = ''
		  startInChars = 0
		  # scan string forward to find index of first character
		  # (convert start position in byte to start position in characters)
		  bytePos = 0
		  while bytePos < startInBytes
		    # get numeric code of character (is >128 for multibyte character)
		    # and increase "bytePos" for each byte of the character sequence
		    ch = str.charCodeAt(startInChars)
		    bytePos += if ch < 128 then 1 else encode_utf8(str[startInChars]).length
		    startInChars++
		  # now that we have the position of the starting character,
		  # we can built the resulting substring
		  # as we don't know the end position in chars yet, we start with a mix of
		  # chars and bytes. we decrease "end" by the byte count of each selected
		  # character to end up in the right position
		  end = startInChars + lengthInBytes - 1
		  n = startInChars
		  while startInChars <= end
		    # get numeric code of character (is >128 for multibyte character)
		    # and decrease "end" for each byte of the character sequence
		    ch = str.charCodeAt(n)
		    end -= if ch < 128 then 1 else encode_utf8(str[n]).length
		    resultStr += str[n]
		    n++
		  resultStr

	  substr_utf8_bytes(str, start, length)

	angular.element($window).bind('resize', () ->

		# change summary text length
		angular.forEach($scope.summaryOri, (value, key) ->

			if $window.innerWidth < 480
				$scope.summary[key] = subStrByByte(value, 0, Math.min(value.length, 60))

			else if $window.innerWidth < 630
				$scope.summary[key] = subStrByByte(value, 0, Math.min(value.length, 120))

			else
				$scope.summary[key] = value
		)

		$scope.$apply()
	)

	$scope.clickPagenator = (url) ->
		window.location = url

	$scope.$apply()


]
