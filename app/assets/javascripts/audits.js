$(document).on('ready page:load', function () {
  $(document).on('click', '.show-audit-details', function (e) {
    $(this).addClass('hidden');
    $(this).parent().find('.audit-details').removeClass('hidden');
    e.stopPropagation();
    e.preventDefault();
    return false;
  });
});