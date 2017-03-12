_root_ = File.expand_path('../../../', __FILE__)

require "#{ _root_ }/lib/image_tools"

# Processor
class Tool; include ImageTools; end
tool = Tool.new

# base paths
src_dir  = "#{ _root_ }/spec/crop_tool/src_images"
dest_dir = "#{ _root_ }/spec/crop_tool/dest_images"

# reset dest dir
tool.destroy_dir dest_dir
tool.create_path_for_file "#{ dest_dir }/filename"

# test_1
src  = "#{ src_dir  }/1200x100.png"
dest = "#{ dest_dir }/test_1.png"

tool.manipulate({ src: src, dest: dest }) do |image, opts|
  to_rect image, 100, 100
end

# test_2
src  = "#{ src_dir  }/100x100.png"
dest = "#{ dest_dir }/test_2.png"

tool.manipulate({ src: src, dest: dest }) do |image, opts|
  to_rect image, 100, 100
end

# test_3
src  = "#{ src_dir  }/1504x846.jpg"
dest = "#{ dest_dir }/test_3.png"

tool.manipulate({ src: src, dest: dest }) do |image, opts|
  to_rect image, 300, 100
end

# test_4
src  = "#{ src_dir  }/600x1000.jpg"
dest = "#{ dest_dir }/test_4.png"

tool.manipulate({ src: src, dest: dest }) do |image, opts|
  to_rect image, 100, 100, { valign: :top }
end

# test_5
src  = "#{ src_dir  }/169x150.jpg"
dest = "#{ dest_dir }/test_5.png"

img_w = 500
x0 = 115
y0 = 52
w = 348.42857142857144
h = 271

tool.manipulate({ src: src, dest: dest }) do |image, opts|
  scale = image[:width].to_f / img_w.to_f
  crop image, x0, y0, w, h, scale
  to_rect image, 270, 210
end
