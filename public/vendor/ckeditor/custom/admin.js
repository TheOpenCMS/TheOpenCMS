/**
 * @license Copyright (c) 2003-2014, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.html or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
  config.language = 'ru';
  config.allowedContent = true;
  config.format_tags = "p;h2;h3;h4;pre;div";

  config.fontSize_sizes = "12/12px;14/14px;16/16px;18/18px;20/20px;22/22px;24/24px;"
  config.font_names = "Arial/Arial, Helvetica, sans-serif;Georgia/Georgia, serif;Tahoma/Tahoma, Geneva, sans-serif;Times New Roman/Times New Roman, Times, serif;Trebuchet MS/Trebuchet MS, Helvetica, sans-serif;Verdana/Verdana, Geneva, sans-serif"

  config.plugins     = "iframe,dialogui,dialog,dialogadvtab,menu,wysiwygarea,toolbar,font,format,colorbutton,removeformat,image,basicstyles,link,blockquote,undo,justify,list,table,tabletools,sourcearea,resize";

  // doesn't work ???
  config.disableNativeSpellChecker = false;
  config.entities = false;

  // config.basePath = "/javascripts/ckeditor/";
  // config.plugins.basePath = "/javascripts/ckeditor/plugins/";

	// config.uiColor = '#AADC6E';
  // config.plugins = "
  //   ,
  //   ,
  //   about,
  //   a11yhelp,
  //   ,
  //   ,
  //   bidi,
  //   ,
  //   clipboard,
  //   button,
  //   panelbutton,
  //   panel,
  //   floatpanel,
  //   ,
  //   colordialog,
  //   templates,
  //   ,
  //   contextmenu,
  //   div,
  //   ,
  //   ,
  //   elementspath,
  //   enterkey,
  //   entities,
  //   popup,
  //   filebrowser,
  //   find,
  //   fakeobjects,
  //   flash,
  //   floatingspace,
  //   listblock,
  //   richcombo,
  //   ,
  //   forms,
  //   ,
  //   horizontalrule,
  //   htmlwriter,
  //   iframe,
  //   ,
  //   ,
  //   indent,
  //   indentblock,
  //   indentlist,
  //   smiley,
  //   ,
  //   menubutton,
  //   language,
  //   ,
  //   ,
  //   liststyle,
  //   magicline,
  //   maximize,
  //   newpage,
  //   pagebreak,
  //   pastetext,
  //   pastefromword,
  //   preview,print,
  //   ,
  //   save,
  //   selectall,
  //   showblocks,
  //   showborders,
  //   ,
  //   specialchar,
  //   scayt,
  //   stylescombo,
  //   tab,
  //   ,
  //   ,
  //   ,
  //   wsc
  // "
};
