function notifications() {
  //highights tab and includes number of uanswered/new votes
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
