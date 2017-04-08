_root_ = File.expand_path('../../../', __FILE__)

require "#{ _root_ }/lib/image_tools"

# Processor
class Tool; include ImageTools; end
tool = Tool.new

src_dir  = "#{ _root_ }/spec/crop_tool/src_images"
dest_dir = "#{ _root_ }/spec/crop_tool/dest_images"

# test_1
src  = "#{ src_dir  }/16017x10677-96dpi.jpg"
dest = "#{ dest_dir }/16017x10677-96dpi_to_580.jpg"

tool.manipulate({ src: src, dest: dest }) do |image, opts|
  biggest_side_not_bigger_than image, 580
end
