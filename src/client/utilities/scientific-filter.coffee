l10 = Math.log(10)
angular.module('eau.utilities.scientific', [
]).filter 'scientific', ->
  (number, digits)->
    number = '' + number # ftoa
    len = number.length
    exponent = number.length - 1
    value = '' + number.charAt(0)
    if digits then value += '.' + number.substr(1, digits)
    value += 'e' + exponent
    value
