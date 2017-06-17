ThinkingSphinx::Index.define :article, with: :active_record do
  indexes title
  indexes intro
  indexes content

  where "state = 'published'"

  has user_id, created_at, updated_at
end
