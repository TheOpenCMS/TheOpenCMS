class DeployKit
  SSL_FILES_SRC = 'ssh_ssl/certs'

  def ssl_files_copy
    return unless config.tools.ssl

    files = config.ssl.files
    return if files.nil? || files.empty?

    files.each do |ssl_file|
      template_upload \
        "#{ SSL_FILES_SRC }/#{ ssl_file }", \
        "#{ ssl_path }/#{ ssl_file }"
    end
  end
end
