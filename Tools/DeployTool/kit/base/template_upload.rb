class DeployKit
  def template_upload from, to, params = {}
    tmpl_file = ::KIT_ROOT + "/#{ kit_templates_path }/#{ app_env }/#{ from }"

    unless File.exist? tmpl_file
      return log_output "File: #{ tmpl_file } doesn't exist"
    end

    namespace = OpenStruct.new(params.merge({kit: self, config: config}))
    erb       = File.read ::KIT_ROOT + "/#{ kit_templates_path }/#{ app_env }/#{ from }"
    res       = ERB.new(erb).result(namespace.instance_eval { binding })

    log_output(res)

    tmp_file = Tempfile.new rand.to_s
    tmp_file.write(res)
    tmp_file.rewind

    copy_file_to_remote(tmp_file.path, to)

    tmp_file.close
    tmp_file.unlink
  end
end
