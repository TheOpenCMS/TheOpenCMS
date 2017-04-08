@AvatarCrop = do ->
  crop_tool_callback: (data, btn_params) ->
    if data?.ids?
      for id, src of data.ids
        $(id).attr 'src', src

    CropTool.finish()
