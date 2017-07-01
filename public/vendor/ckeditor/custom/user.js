CKEDITOR.editorConfig = function( config ) {
  config.language = 'ru';
  config.allowedContent = true;
  config.format_tags = "p;h2;h3;h4;pre;div";

  // config.fontSize_sizes = "8/8px;9/9px;10/10px;11/11px;12/12px;14/14px;16/16px;18/18px;20/20px;22/22px;24/24px;26/26px;28/28px;36/36px;48/48px;72/72px";
  // config.font_names = "Arial/Arial, Helvetica, sans-serif;Comic Sans MS/Comic Sans MS, cursive;Courier New/Courier New, Courier, monospace;Georgia/Georgia, serif;Lucida Sans Unicode/Lucida Sans Unicode, Lucida Grande, sans-serif;Tahoma/Tahoma, Geneva, sans-serif;Times New Roman/Times New Roman, Times, serif;Trebuchet MS/Trebuchet MS, Helvetica, sans-serif;Verdana/Verdana, Geneva, sans-serif"

  config.disableNativeSpellChecker = false;
  config.fontSize_sizes = "12/12px;14/14px;16/16px;18/18px;20/20px;22/22px;24/24px;";
  config.font_names = "Arial/Arial, Helvetica, sans-serif;Georgia/Georgia, serif;Tahoma/Tahoma, Geneva, sans-serif;Times New Roman/Times New Roman, Times, serif;Trebuchet MS/Trebuchet MS, Helvetica, sans-serif;Verdana/Verdana, Geneva, sans-serif";

  config.plugins  = "dialogui,dialog,dialogadvtab" +
  ",sourcearea,menu,wysiwygarea,toolbar" +
  ",font,format,removeformat,image" +
  ",basicstyles,link,blockquote,undo" +
  ",justify,list,table,tabletools,resize";

  config.entities = false;
};
