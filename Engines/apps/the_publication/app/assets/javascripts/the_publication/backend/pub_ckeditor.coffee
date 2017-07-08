@PubCKEditor = do ->
  editor_included: -> typeof(CKEDITOR) isnt 'undefined'

  destroy_all: ->
    for name, instance of CKEDITOR.instances
      instance.destroy(true)

  init: ->
    unless PubCKEditor.init_editor()
      setTimeout (=> PubCKEditor.init_editor()), 1000

  init_editor: ->
    if PubCKEditor.editor_included()
      PubCKEditor.editors_setup()
      return true

  editors_setup: ->
    PubCKEditor.destroy_all()

    setTimeout =>
      $('#pub_intro').prop('disabled', false)
      $('#pub_content').prop('disabled', false)

      if $('#pub_intro').length
        unless CKEDITOR.instances['pub_intro']
          CKEDITOR.replace 'pub_intro',
            height: 200

      if $('#pub_content').length
        unless CKEDITOR.instances['pub_content']
          CKEDITOR.replace 'pub_content',
            height: 500
    , 1000

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
