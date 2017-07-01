@PubCKEditor = do ->
  init: ->
    log 'CKEditor Initializer'

    try
      PubCKEditor.editors_setup()
    catch e
      log 'CKE Not loaded'
      log e

      setTimeout ->
        PubCKEditor.editors_setup()
      , 2000

  editors_setup: ->
    has_intro      = $('#redactor_intro').length > 0
    intro_uninited = $('#cke_redactor_intro').length is 0
    if has_intro && intro_uninited
      CKEDITOR.replace 'redactor_intro', { height: 200 }

    has_cont      = $('#redactor_content').length > 0
    cont_uninited = $('#cke_redactor_content').length is 0
    if has_cont && cont_uninited
      CKEDITOR.replace 'redactor_content', { height: 500 }

    do @customizer

  customizer: ->
    log 'Customizer'

    CKEDITOR.on 'dialogDefinition', (ev) ->
      dialogName = ev.data.name
      dialogDefinition = ev.data.definition

      if dialogName is 'link'
        advTab = dialogDefinition.getContents('advanced')
        advRel = advTab.get('advRel')
        advRel.default = 'nofollow'

      if dialogName is 'image'
        pub_title = $('.js--cke-editor--pub-title').val()

        infoTab = dialogDefinition.getContents('info')
        advTab  = dialogDefinition.getContents('advanced')

        alt_text = infoTab.get('txtAlt')
        alt_text.default = pub_title

        advTitle = advTab.get('txtGenTitle')
        advTitle.default = pub_title
