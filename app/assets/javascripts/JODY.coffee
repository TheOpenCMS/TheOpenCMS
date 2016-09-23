# JsOn for DYnamic sites
#
# JS middleware which does boring routine work
# Based on `conventions over configurations`
# Just give to JODY suitable JSON data object and JODY will do what you want
#
@JODY = do ->
  process: (data) ->
    # SET HTML
    if idsToSet = data?.html_content?.html
      for id, html of idsToSet
        $(id).html(html)

    # REPLACE HTML
    if idsToReplace = data?.html_content?.replaceWith
      for id, html of idsToReplace
        $(id).replaceWith(html)
