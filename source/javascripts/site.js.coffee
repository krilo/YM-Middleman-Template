//= require "_vendor/jquery-1.6.4.min"
//= require "_vendor/respond-1.0.0.min"

//= require "ym/Core"
//= require "ym/utils/Tween"
//= require "ym/utils/Animations"
//= require "ym/ui/Dropdown"

$ ->
  
  dropdownElement = document.getElementById("dropdown01");
  
  dropdown = new ym.Dropdown(dropdownElement)
  dropdown.init()
