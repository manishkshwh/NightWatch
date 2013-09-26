root = exports ? this



class Dashing.Nightwatch extends Dashing.Widget
  ready: ->
    $("#addbtn").click ->
      sendAjax("add", $("#newUrl").val())
      return
    $("#removebtn").click ->
      sendAjax("remove", $("#removeUrl").val())
      return
    $("#freeze").click ->
      sendAjax("freeze", null)
      return
    shows()
    return

  onData: (data) ->
    sort(data.length)
    shows()

  sort = (length) ->
    $("iframe").contents().find("img").each ->
      imgid = $(this).attr('id')
      thisid = parseInt(imgid, 10)
      thisid = thisid + 1
      if thisid is length
        thisid = parseInt(0, 10)
      $(this).attr('id', thisid)

  shows = () ->
    $("iframe").contents().find("img").each ->
      if $(this).attr('id') isnt $(this).attr('class')
        $(this).hide()
      else
        $(this).prependTo($(this).parent())
        $(this).show()

  root.sendAjax = (action, words) ->
    switch action
      when "add"
        url = "/nightwatch/addUrl?url=#{words}"
      when "remove"
        url = "/nightwatch/removeUrl?url=#{words}"
      when "freeze"
        url = "/nightwatch/freeze"
    #create the message
    $.ajax
      async: true
      url: "#{url}"
      type: 'GET'
      dataType: 'json'
      error: (jqXHR, textStatus, errorThrown) ->
        $("body").append "failure"
      success: (data, textStatus, jqXHR) ->
        $("body").append "success"
