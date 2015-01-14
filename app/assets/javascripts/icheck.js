function icheck() {
  if($(".icheck-me").length > 0){
    $(".icheck-me").each(function(){
      var $el  = $(this);
      var skin = ($el.attr('data-skin')  !== undefined) ? "_" + $el.attr('data-skin') : "",
      color    = ($el.attr('data-color') !== undefined) ? "-" + $el.attr('data-color') : "";
      var opt  = {
        checkboxClass: 'icheckbox' + skin + color,
        radioClass: 'iradio' + skin + color,
      }
      // add logs to trace
      console.log("$el => " + $el.text);
      console.log("this => " + this);
      console.log("skin => " + skin);
      console.log("color => " + color);
      $el.iCheck(opt);
    });
  }
}
