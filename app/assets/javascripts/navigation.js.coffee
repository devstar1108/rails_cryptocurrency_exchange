$(document).on('ready page:load', ->
  $(document).on('click', '#navlink-sign-up', (e) ->
    $('#sign-in-sign-up-tabs').easytabs('select', '#sign-up')
    return
  )

  $(document).on('click', '#navlink-sign-in', (e) ->
    $('#sign-in-sign-up-tabs').easytabs('select', '#sign-in')
    return
  )

  $('#navlink-markets').click( ->
    location.href = $(this).data('link')
    return
  )
  return
)