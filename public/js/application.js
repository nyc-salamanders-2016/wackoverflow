$(document).ready(function() {
  $(".votable-container").on('submit', '.vote-form', function () {
    event.preventDefault();
    var $target = $(event.target)
    $.ajax({
      method: $(event.target).attr('method'),
      url: $(event.target).attr('action'),
      data: {
        value: $(event.target).find('button').attr('value')
      }
    }).done(function(response){
      $target.siblings('p').text(response['points']);
    });
  });
});
