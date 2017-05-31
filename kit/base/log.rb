class DeployKit
  def log cmd
    puts ('>'*60).light_yellow
    puts cmd.yellow
    puts ('<'*60).light_yellow
  end

  def log_cmds cmds
    cmds = cmds_to_ary(cmds)
    cmds = cmds_compact(cmds)
    cmds = cmds.any? ? cmds : ['NO COMMANDS TO LOG']

    puts ('>'*60).light_blue
    puts cmds.map{|cmd| "$ " + cmd.strip }.join("\n").light_blue
    puts ('<'*60).light_blue
  end

  def log_output output
    puts output.light_red
  end
end
