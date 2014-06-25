$ ->
  $('#select_zone').change ->
    $.ajax(
      type: 'POST'
      url: $(this).data('href')
      data:
        zone: $(this).val()
    ).done ->
      window.location.reload()
