#encoding: utf-8
# 此代码用于来电通

//= require jquery 
//= require jquery_ujs
//= require jquery.json24.min

(->
  $ ->
    $("#pcall_form").submit ->
      vdata = $(this).serialize()
      num1 = $("#phone_call_from_phone").val()
      if num1 isnt "" and not num1.match(/^1[3|4|5|8][0-9]\d{4,8}$/)
        alert "请输入正确的手机号码"
        return false
      $.ajax
        type: "GET"
        dataType: "JSONP"
        contentType: "application/json; charset=utf-8"
        url: "http://www.65960.com/pcall?callback=?"
        data: vdata
        success: (data) ->
          alert data.id + " 成功发送！"
          false

        error: ->
          alert "成功发送！"
          false

      alert "信息已提交，请耐心等待！"
      $("#phone_call_from_phone").val ""
      false
).call this
