jQuery(function() {
  $('a[rel~=popover], .has-popover').popover();
  $('a[rel~=tooltip], .has-tooltip').tooltip();

  $('.test').click(() => {
    console.log('test');
  });
});
