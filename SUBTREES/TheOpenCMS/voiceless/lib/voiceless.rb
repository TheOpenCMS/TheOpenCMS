require 'colorize'

def voiceless
  begin
    yield
  rescue Exception => e
    puts (">"*50).red
    puts "VOICELESS ALERT: #{ e.message.to_s }".red

    line = caller.each_with_index.map do |item, index|
      caller[index].split(':')[0..1].join(':')
    end.compact.select do |item|
      item unless item =~ /voiceless/mix
    end.first.to_s

    puts line.yellow if line.present?
    puts ("<"*50).red
  end
end
