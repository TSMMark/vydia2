window.console ||=
  log:(->)
  info:(->)
  debug:(->)
  warn:(->)
  error:(->)

$.fn.selectOnFocus = ->
  @each ->
    $$ = $ @
    $$.on 'focus mouseup', ->
      $$.select()

      setTimeout( ->
        $$.select()
      , 1)

      mouseUpHandler = ->
        # Prevent further mouseup intervention
        $$.off "mouseup", mouseUpHandler
        false

      $$.mouseup mouseUpHandler

# $.data.every = []
# $.fn.every = ->
#   return false if typeof @ == "function"
  