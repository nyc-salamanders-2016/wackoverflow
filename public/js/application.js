$(document).ready(function() {
  $(".votable-container").on('submit', '.vote-form', function (event) {
    event.preventDefault();
    var $target = $(event.target)
    $.ajax({
      method: $target.attr('method'),
      url: $target.attr('action'),
      data: {
        value: $target.find('button').attr('value')
      }
    }).done(function(response){
      $target.siblings('p').text(response['points']);
    });
  });

  $(".votable-container").on('click', '.edit-link', function (event) {
    event.preventDefault();
    var $target = $(event.target);
    $.ajax({
      method: 'get',
      url: $target.attr('href')
    }).done(function(response){
      $target.closest('li').find('.body-text').replaceWith(response);
    });
  });

  $(".votable-container").on('submit', '.edit-form', function (event) {
    event.preventDefault();
    var $target = $(event.target);
    $.ajax({
      method: $target.attr('method'),
      url: $target.attr('action'),
      data: $target.serialize()
    }).done(function(response){
      $target.replaceWith(response);
    });
  });

  $(".votable-container").on('submit', '.delete-form', function(event) {
    event.preventDefault();
    var $target = $(event.target);
    $.ajax({
      method: "delete",
      url: $target.attr('action')
    }).done(function(response){
      $target.closest('li').remove();
    });
  });

  $(".login-link").click(function(event) {
    event.preventDefault();
    var $target = $(event.target);
    $.ajax({
      method: "get",
      url: $target.attr('href')
    }).done(function(response){
      $target.closest('nav').append(response);
    });
  });

  $(".votable-container").on('click','#question-comment', function (event){
    event.preventDefault();
    console.log("hi")
    var $target = $(event.target);
    // $.ajax({
    //   method:
    //   url:

    // })
  })
});


