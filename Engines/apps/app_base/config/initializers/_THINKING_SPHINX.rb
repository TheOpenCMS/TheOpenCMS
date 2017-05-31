if defined? ThinkingSphinx
  class ThinkingSphinx::Configuration
    private

    def settings_file
      framework_root.join 'config', 'ENV', Rails.env.to_s, 'services', 'thinking_sphinx.yml'
    end
  end
end
