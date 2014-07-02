$(document).on('page:load ready', function () {
  $('#select_zone').on('change', function() {
    return $.ajax({
      type: 'POST',
      url: $(this).data('href'),
      data: {
        zone: $(this).val()
      }
    }).done(function() {
      return window.location.reload();
    });
  });
});
