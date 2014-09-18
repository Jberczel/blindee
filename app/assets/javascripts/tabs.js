
function tabs() {

var menu = $('.centered-navigation-menu');
var menuToggle = $('.centered-navigation-menu-button');
var signUp = $('.sign-up');

$(menuToggle).on('click', function(e) {
  e.preventDefault();
  menu.slideToggle(function(){
    if(menu.is(':hidden')) {
      menu.removeAttr('style');
    }
  });
});

$('.accordion-tabs-minimal').each(function(index) {
  $(this).children('li').first().children('a').addClass('is-active').next().addClass('is-open').show();
});

$('.accordion-tabs-minimal').on('click', 'li > a', function(event) {
  if (!$(this).hasClass('is-active')) {
    event.preventDefault();
    var accordionTabs = $(this).closest('.accordion-tabs-minimal')
    accordionTabs.find('.is-open').removeClass('is-open').hide();

    $(this).next().toggleClass('is-open').toggle();
    accordionTabs.find('.is-active').removeClass('is-active');
    $(this).addClass('is-active');
  } else {
    event.preventDefault();
  }
});

}

function notifications() {
    //counts for unanswered votes
  var invite_votes = $(".invites .ribbon").length;
  var my_votes     = $(".questions .ribbon").length;

  if (invite_votes > 0) {
    $(".invite-link").append(" <small>(" + invite_votes + ")</small");
    $(".invite-link i").css( "color", "#0093d0" );

  }
  if (my_votes > 0) {
    $(".my-link").append(" <small>(" + my_votes + ")</small>");
    $(".my-link i").css( "color", "#0093d0" );
  }
}