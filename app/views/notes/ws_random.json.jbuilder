json.set! :html_content, {
  html: {
    '.js-current-time': Time.now.to_s(:db)
  },

  replaceWith: {
    '.js-notes-random_note' => render_view(
      layout: false,
      template: 'notes/random',
      locals: { note: Note.random.first}
    )
  }
}
