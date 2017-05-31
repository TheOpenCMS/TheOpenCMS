class DeployKit
  # development? | staging? | production?
  %w[ development staging production ].each do |env|
    define_method "#{ env }?" do
      app_name == env
    end
  end

  def ssh_escape(str)
    str.gsub("'", '"\'"')
  end

  # def set_kit_gemfile_path!
  #   ENV['BUNDLE_GEMFILE'] = "#{ KIT_ROOT }/Gemfile"
  #   remote_exec 'env | grep BUNDLE_GEMFILE'
  # end

  def cmds_empty?(cmds)
    return true if cmds.nil?
    return true if cmds.is_a?(Array) && cmds.join('').strip.size.zero?
    cmds.size.zero?
  end

  def cmds_compact cmds
    cmds.map{|cmd| cmd.strip.split.join(" ").gsub("\n", '') }
  end

  def cmds_to_ary cmds
    klass = cmds.class.to_s
    return cmds   if klass == 'Array'
    return [cmds] if klass == 'String'
    return []     if klass == 'NilClass'

    raise 'Undefined type of Commands'
  end

  def cmds_prepare cmds
    cmds_compact(cmds).join(' && ')
  end

  def process_exists?(pid_file)
    return false unless remote_file_exists?(pid_file)
    pid = remote_exec("cat #{pid_file}").chomp
    result = remote_exec("ps -p #{pid} -o comm=").chomp
    !result.empty?
  end
end
