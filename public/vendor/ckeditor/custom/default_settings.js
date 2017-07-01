CKEDITOR.editorConfig = function( config ) {
  // config.allowedContent = true;
  config.disableNativeSpellChecker = false;

  config.extraPlugins = 'sourcedialog,font,dialogadvtab,justify';
  config.removePlugins = 'sourcearea,scayt';

  config.format_tags = "p;h2;h3;h4;pre;div";

  config.fontSize_sizes = "10/10px;11/11px;12/12px;14/14px;16/16px;18/18px;20/20px;22/22px;24/24px;26/26px;28/28px;32/32px;";

  config.font_names = "Arial/Arial, Helvetica, sans-serif;" +
              "Verdana/Verdana, Geneva, sans-serif" +
              "Georgia/Georgia, serif;" +
              "Times New Roman/Times New Roman, Times, serif;";

  config.toolbarGroups = [
    { name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi', 'paragraph' ] },
    { name: 'clipboard', groups: [ 'clipboard', 'undo' ] },
    { name: 'editing', groups: [ 'find', 'selection', 'editing' ] },
    { name: 'forms', groups: [ 'forms' ] },
    { name: 'tools', groups: [ 'tools' ] },
    { name: 'document', groups: [ 'mode', 'document', 'doctools' ] },
    { name: 'others', groups: [ 'others' ] },
    '/',
    { name: 'insert', groups: [ 'insert' ] },
    { name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
    { name: 'styles', groups: [ 'styles' ] },
    { name: 'links', groups: [ 'links' ] }
  ];

  config.removeButtons = 'Styles,Cut,Copy,Paste,PasteText,PasteFromWord,HorizontalRule,About';
}
