// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

BtcApp = {};

BtcApp.enableToggle = function _enableToggle() {
  $("#toggle-link").click(function(ev) {
    ev.preventDefault();

    $.ajax({
      url: "/accounts/toggle.json",
      type: "POST",
      success: function(data, textStatus, jQxhr) {
        if (data.enabled) {
          $(".buy-sell").removeClass("auto-buy-sell-disabled");
          $(".buy-sell").addClass(   "auto-buy-sell-enabled" );
          $(".buy-sell").text("Auto Buy/Sell is enabled for this account. This app will execute buy/sell orders based on current trends.");
          $("#toggle-link").text("Disable auto buy/sell");
        } else if (!data.enabled) {
          $(".buy-sell").removeClass("auto-buy-sell-enabled" );
          $(".buy-sell").addClass(   "auto-buy-sell-disabled");
          $(".buy-sell").text("Auto Buy/Sell is disabled for this account. You can add BTC to the wallet but it will not execute any buy/sell orders.");
          $("#toggle-link").text("Enable auto buy/sell");
        }
      }
    });
  });
};
