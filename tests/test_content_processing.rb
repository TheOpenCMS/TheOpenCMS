require_relative './env.rb'

str = <<-TXT_STRING
Мой сайт - http://open-cook.ru
TXT_STRING

al_helper = ::AutoLink.new

x = ::ContentForProcessing.process(str) do |txt|
  res = al_helper.auto_link(txt, sanitize: false, html: { target: :_blank, rel: :nofollow })
  res = ::Markdown2Tags.process(res)
end

puts x