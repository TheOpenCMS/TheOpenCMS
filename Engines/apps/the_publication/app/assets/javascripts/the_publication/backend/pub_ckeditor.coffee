@PubCKEditor = do ->
  init: ->
    log('Init CKEditors')

    require [
      'ckeditor/ckeditor/ckeditor'
    ], (CKeditor) ->
      CKEDITOR_BASEPATH = CONTENT_EDITOR.config.base_path;
      CKEDITOR.config.language     = CONTENT_EDITOR.config.language;
      CKEDITOR.config.customConfig = CONTENT_EDITOR.config.customConfig;
      CKEDITOR.config.contentsCss  = CONTENT_EDITOR.config.contentsCss;

      PubCKEditor.init_items()

  init_items: ->
    $('#pub_intro, #pub_content').prop('disabled', false)

    CKEDITOR.replace 'pub_intro',
      height: 200

    CKEDITOR.replace 'pub_content',
      height: 500

    do @customizer

  customizer: ->
    CKEDITOR.on 'dialogDefinition', (ev) ->
      dialogName = ev.data.name
      dialogDefinition = ev.data.definition

      if dialogName is 'link'
        advTab = dialogDefinition.getContents('advanced')
        advRel = advTab.get('advRel')
        advRel.default = 'nofollow'

      if dialogName is 'image'
        pub_title = $('.js-pub-title').val()

        infoTab = dialogDefinition.getContents('info')
        advTab  = dialogDefinition.getContents('advanced')

        alt_text = infoTab.get('txtAlt')
        alt_text.default = pub_title

        advTitle = advTab.get('txtGenTitle')
        advTitle.default = pub_title
