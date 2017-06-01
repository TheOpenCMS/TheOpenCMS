class CreateArticlePublicationModel < ActiveRecord::Migration[5.1]
  def change
    create_table 'articles' do |t|
      t.integer :user_id

      # Friendly ID
      t.string :slug,        default: ''
      t.string :short_id,    default: ''
      t.string :friendly_id, default: ''

      # Base
      t.string :title, default: ''

      t.text :raw_intro
      t.text :intro

      t.text :raw_content
      t.text :content

      # Editor
      t.string :editor_type, default: :ckeditor

      # View Templates
      t.string :view_layout,   default: ''
      t.string :view_template, default: ''

      # Counters
      t.integer :view_counter, default: 0

      # Publication State: draft | published | deleted
      t.string :state, default: :draft

      # Access tocken to draft publications
      t.string :access_token, default: ''

      # DateTime
      t.datetime :published_at
      t.timestamps
    end
  end
end
