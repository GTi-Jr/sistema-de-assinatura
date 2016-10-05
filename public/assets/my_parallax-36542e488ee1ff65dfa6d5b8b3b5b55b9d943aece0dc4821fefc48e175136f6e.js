(function() {
  $(document).ready(function() {
    return $('.parallax').each(function(index, value) {
      $(this).css('background-image', "url(" + ($(this).attr('image-url')) + ")");
      if ($(this).attr('height')) {
        return $(this).css('height', $(this).attr('height'));
      }
    });
  });

}).call(this);
