ThinkingSphinx::Index.define :note, :with => :active_record do
  indexes title
  indexes content

  has user_id, created_at, updated_at
end
