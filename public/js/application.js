$(document).ready(function() {
  $(".votable-container, .score-container").on('submit', '.vote-form', function (event) {
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

  $(".votable-container, .comments-container").on('submit', '.delete-form', function(event) {
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

  $(".add-comment").click( function (event) {
    event.preventDefault();
    var $target = $(event.target);
    $.ajax({
      method: "get",
      url: $target.attr('href')
    }).done(function(response){
      $target.after(response)
    });
  });

  $(".add-comment-container").on('submit', '.new-comment-form', function(event) {
    event.preventDefault();
    var $target = $(event.target);
    $.ajax({
      method: $target.attr('method'),
      url: $target.attr('action'),
      data: $target.serialize()
    }).done(function(response){
      $target.parent().siblings('.comments-container').append(response);
      $target.remove()
    });
  });

  $(".add-answer").click( function (event) {
    event.preventDefault();
    var $target = $(event.target);
    $.ajax({
      method: "get",
      url: $target.attr('href')
    }).done(function(response){
      $target.after(response)
    });
  });

  $(".answer-question").on('submit', '.new-answer-form', function(event) {
    event.preventDefault();
    var $target = $(event.target);
    $.ajax({
      method: $target.attr('method'),
      url: $target.attr('action'),
      data: $target.serialize()
    }).done(function(response){
      $('.answers-list').append(response);
      $target.remove()
    });
  });
});


