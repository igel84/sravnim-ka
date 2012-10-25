jQuery.fn.my_upload = ->
  $(this).fileupload
    dataType: "script"
    add: (e, data) ->
      types = /(\.|\/)(xls)$/i
      file = data.files[0]
      if types.test(file.type) || types.test(file.name)
        data.context = $(tmpl("template-upload", file))
        $(this).append(data.context)
        data.submit()
      else
        alert("#{file.name} is not a xls file")
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.bar').css('width', progress + '%')