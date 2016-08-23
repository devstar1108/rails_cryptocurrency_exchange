angular.module('textFilters', []).filter 'truncate', ->
  (text, size) ->
    if text.length > 6
      text.slice(0, size) + '...'
    else
      text
