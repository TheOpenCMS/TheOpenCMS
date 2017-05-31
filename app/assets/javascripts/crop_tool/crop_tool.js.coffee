@CropTool = do ->
  # HELPERS
  dec: (val) -> parseInt val, 10

  # INIT
  init: ->
    @doc = $ document

    @inited ||= do =>
      @params = {}
      do @init_open_btn
      do @init_close_btn
      do @init_submit
      do @init_ajaxian_callback

  init_open_btn: ->
    @doc.on 'click', '.js-crop_tool-open', (e) =>
      link    = $ e.currentTarget
      params  = link.data()
      @params = params if params

      $('.js-crop_tool-jcrop_target').one "load", =>
        log "IMG LOADED"
        @show_canvas()
        @create(params)

      $('.js-crop_tool-jcrop_target, .js-crop_tool-preview')
        .removeAttr('src')
        .attr 'src', @params.source

  finish: ->
    do @destroy
    do @hide_canvas

  init_close_btn: ->
    @doc.on 'click', '.js-crop_tool-close', -> CropTool.finish()

  init_submit: ->
    @doc.on 'click', '.js-crop_tool-submit', =>
      form = $('.js-crop_tool-form')

      x = $('.js-crop_tool-x', form).val()
      y = $('.js-crop_tool-y', form).val()
      w = $('.js-crop_tool-w', form).val()
      h = $('.js-crop_tool-h', form).val()

      if x is '0' && y is '0' && w is '0' && h is '0'
        alert 'Please, select crop area'
      else
        $('.js-crop_tool-form').submit()

      false

  init_ajaxian_callback: ->
    @doc.on 'ajax:success', '.js-crop_tool-form', (e, data, status, xhr) =>
      callback = null
      fn_chain = @params.callbackHandler.split '.'

      for fn in fn_chain
        callback = if callback then callback[fn] else window[fn]

      callback(data, @params) if callback

  init_crop_form: ->
    $('.js-crop_tool-form').attr('action', @params.url)

  init_jcrop: (context) =>
    $('.js-crop_tool-jcrop_target').Jcrop
      onChange: context.buildPreview
      onSelect: context.buildPreview
      setSelect: [0,0,100,100]
      aspectRatio: context.get_aspect_ration()
    , ->
      context.api = @

  # GETTERS
  get_aspect_ration: ->
    prev = $('.js-crop_tool-preview_image')
    CropTool.dec(prev.css('width')) / CropTool.dec(prev.css('height'))

  # SETTERS
  set_crop_form_params: (c) ->
    form     = $('.js-crop_tool-form')
    orig_img = $('.js-crop_tool-jcrop_target')

    # Set img size for calc scale value
    img_w = $('#crop_img_w', form)
    img_w.val CropTool.dec orig_img.css('width')

    # Set crop params
    x = $('.js-crop_tool-x', form)
    y = $('.js-crop_tool-y', form)
    w = $('.js-crop_tool-w', form)
    h = $('.js-crop_tool-h', form)

    x.val(c.x); y.val(c.y)
    w.val(c.w); h.val(c.h)

  set_preview_defaults: ->
    $('.js-crop_tool-preview_image').css
      width:  300
      height: 300

  set_preview_dimensions: ->
    if prev_opt = @params?.preview
      if prev_opt?.width && prev_opt?.height
        $('.js-crop_tool-preview_image').css
          width:  prev_opt.width
          height: prev_opt.height

  set_holder_defaults: ->
    if holder_opt = @params?.holder
      if holder_opt?.width
        $('.js-crop_tool-source_image').css
          width: holder_opt.width

  set_holder_image_same_dimentions: ->
    holder  = $('.js-crop_tool-source_image')
    src_img = $('.js-crop_tool-jcrop_target')

    h_width = @dec holder.css('width')
    src_img.css { width: h_width }

    w_scale = src_img.width()/src_img[0].naturalWidth
    src_img_height = @dec src_img[0].naturalHeight * w_scale

    src_img.css { height: src_img_height }
    holder.css  { height: src_img_height }

  set_canvas_dimensions: ->
    do @set_preview_defaults
    do @set_preview_dimensions

    do @set_holder_defaults
    do @set_holder_image_same_dimentions

  ##########################################
  # FUNCTIONS
  ##########################################

  create: ->
    log "CROP WARN! API ALREADY DEFINED" if @api
    do @set_canvas_dimensions
    do @init_crop_form
    @init_jcrop @

  destroy: ->
    @api.destroy()

  buildPreview: (coords) ->
    preview_holder  = $('.js-crop_tool-preview_image')
    original_img    = $('.js-crop_tool-jcrop_target')

    preview_view_w = CropTool.dec preview_holder.css('width')
    preview_view_h = CropTool.dec preview_holder.css('height')

    original_view_w = CropTool.dec original_img.css('width')
    original_view_h = CropTool.dec original_img.css('height')

    orig_image_w = $('.js-crop_tool-jcrop_target')[0].naturalWidth

    ##########################################
    ### Calculate scale
    ##########################################

    scale = original_view_w / orig_image_w
    sw = CropTool.dec coords.w / scale
    sh = CropTool.dec coords.h / scale

    # Set scaled sizes
    # CropTool.set_croped_image_size_info(sw, sh)

    ##########################################
    ### When crop-area not selected
    ##########################################

    if sw is 0 && sh is 0
      CropTool.set_crop_form_params({ x: 0, y: 0, w: 0, h: 0 })
    else
      CropTool.set_crop_form_params(coords)

    # Calculate values for preview
    rx = preview_view_w / coords.w
    ry = preview_view_h / coords.h

    $('.js-crop_tool-preview').css
      width:  "#{ Math.round(rx * original_view_w) }px"
      height: "#{ Math.round(ry * original_view_h) }px"

      marginLeft: "-#{ Math.round(rx * coords.x) }px"
      marginTop:  "-#{ Math.round(ry * coords.y) }px"

  # OTHERS
  show_canvas: ->
    canvas = $('.js-crop_tool-canvas')

    canvas.css
      width:  @doc.width()
      height: @doc.height()

    canvas.fadeIn()

  hide_canvas: ->
    $('.js-crop_tool-canvas').fadeOut()
