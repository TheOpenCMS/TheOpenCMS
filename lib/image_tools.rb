require 'mini_magick'

# MiniMagick.configure do |config|
#   config.debug = true
# end

module ImageTools
  def base_chmod_mask
    0644
  end

  # HELPERS
  class << self
    def file_name file_name
      file_name = File.basename(file_name)
      ext       = File.extname(file_name)
      File.basename(file_name, ext).to_s
    end

    def file_ext file_name
      File.extname(file_name)[1..-1].to_s
    end
  end

  def open_image path
    ::MiniMagick::Image.open path
  end

  def path_to_file file_path
    file_path.split('/')[0...-1].join('/')
  end

  def create_path_for_file file_path
    FileUtils.mkdir_p path_to_file(file_path)
  end

  def create_path_for_dir path
    FileUtils.mkdir_p path
  end

  def destroy_file file_path
    FileUtils.rm(file_path.compact, force: true)
  end

  def destroy_dir_of_file file_path
    FileUtils.rm_rf path_to_file(file_path.compact)
  end

  def destroy_dir dir_path
    FileUtils.rm_rf dir_path
  end

  # BASE METHODS
  def landscape? image
    image[:width] > image[:height]
  end

  def portrait? image
    image[:width] < image[:height]
  end

  def manipulate opts = {}, &block
    src    = opts[:src]
    dest   = opts[:dest]
    format = opts[:format]
    image  = open_image src

    image.format(format.to_s.downcase) if format
    image = instance_exec(image, opts, &block)

    create_path_for_file(dest)
    image.write dest

    FileUtils.chmod(base_chmod_mask, dest)
  end

  # Image manipulate
  # Resizing can be wrong when .EXT of file is wrong
  def strict_resize image, w, h
    image.resize "#{ w }x#{ h }!"
    image
  end

  def resize image, w, h
    image.resize "#{ w }x#{ h }"
    image
  end

  def resize_w image, w
    image.resize "#{ w }x"
    image
  end

  def resize_h image, h
    image.resize "x#{ h }"
    image
  end

  def rotate image, angle
    image.rotate angle
    image
  end

  def rotate_left image
    rotate image, '-90'
  end

  def rotate_right image
    rotate image, '90'
  end

  # OPTIMIZE

  def strip image
    image.strip
    image
  end

  def auto_orient image
    image.auto_orient
    image
  end

  def optimize image, quality = 85, depth = 8, interlace = :plane
    image.combine_options do |c|
      c.quality   quality.to_s
      c.depth     depth.to_s
      c.interlace interlace.to_s
    end

    image
  end

  # USEFUL METHODS

  def biggest_side_not_bigger_than image, size
    if landscape?(image)
      (image[:width] > size.to_i) ? image.resize("#{ size }x") : image
    else
      (image[:height] > size.to_i) ? image.resize("x#{ size }") : image
    end
  end

  # get rectangle from image
  def to_rect image, width, height, opts = {}
    default_opts = { valign: :center, align: :center, repage: true }
    opts = default_opts.merge(opts)

    align  = opts[:align].to_sym
    valign = opts[:valign].to_sym
    # repage = '+repage' if opts[:repage]

    w0, h0 = image[:width].to_f, image[:height].to_f
    w1, h1 = width.to_f, height.to_f
    fw, fh = w0, h0

    scale = ((w1 / w0) > (h1 / h0)) ? (w1 / w0) : (h1 / h0)

    fw = (w1 / scale).to_i
    fh = (h1 / scale).to_i

    x0 = case align
      when :center
        (w0 - fw) / 2
      when :right
        w0 - fw
      else
        0
    end.to_i

    y0 = case valign
      when :center
        (h0 - fh) / 2
      when :bottom
        h0 - fh
      else
        0
    end.to_i

    crop_cmd   = "#{ fw }x#{ fh }+#{ x0 }+#{ y0 }"
    resize_cmd = "#{ width.to_i }x#{ height.to_i }!"

    image.combine_options do |c|
      c.crop crop_cmd
      c.repage.+ if opts[:repage]
      c
    end

    image.resize resize_cmd

    image
  end

  # get rectangle from image from middle or top
  # `v_ratio_min` and `v_ratio_max` define W/H ratio
  # when we have to get middle or top part of image
  def smart_rect image, width, height, opts = {}
    default_opts = { v_ratio_min: 0.625, v_ratio_max: 0.80, repage: true }
    opts = default_opts.merge(opts)

    repage      = opts[:repage]
    v_ratio_min = opts[:v_ratio_min]
    v_ratio_max = opts[:v_ratio_max]

    scale_w = 1.0/(image.width.to_f/width.to_f)
    scale_h = 1.0/(image.height.to_f/height.to_f)
    scale   = scale_w > scale_h ? scale_w : scale_h

    # original image ratio
    ratio = image.width.to_f/image.height.to_f

    valign = :center
    valign = :top if ratio >= v_ratio_min && ratio <= v_ratio_max

    new_w = image.width*scale
    new_h = image.height*scale

    image = to_rect image, new_w, new_h,  { valign: :center, align: :center, repage: repage }
    image = to_rect image, width, height, { valign: valign,  align: :center, repage: repage }
    image
  end

  # just to square
  def to_square image, size, opts = {}
    to_rect image, size, size, opts
  end

  # scale = original_iamge[:width].to_f / image_on_screen[:width].to_f
  # usually scale should be 1
  def crop image, x0 = 0, y0 = 0, w = 100, h = 100, opts = {}
    default_opts = { scale: 1, repage: true }
    opts = default_opts.merge(opts)

    scale  = opts[:scale]

    x0 = (x0.to_f * scale).to_i
    y0 = (y0.to_f * scale).to_i

    w = (w.to_f * scale).to_i
    h = (h.to_f * scale).to_i

    crop_cmd = "#{ w }x#{ h }+#{ x0 }+#{ y0 }"

    image.combine_options do |c|
      c.crop crop_cmd
      c.repage.+ if opts[:repage]
      c
    end

    image
  end
end
