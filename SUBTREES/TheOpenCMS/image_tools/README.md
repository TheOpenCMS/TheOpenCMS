# ImageTools

A few helpers for image processing and manipulations

```ruby
class Image < ApplicationRecord
  include ::ImageTools
  after_save :file_processing

  def file_processing
    src = file.path

    # Define file paths
    v1600x900 = file.path :v1600x900
    v1280x720 = file.path :v1280x720

    # Create paths
    create_path_for_file v1600x900
    create_path_for_file v1280x720

    # Process image
    manipulate({ src: src, dest: src, larger_side: 1600 }) do |image, opts|
      image = auto_orient image
      image = optimize    image
      image = strip       image
      image = biggest_side_not_bigger_than(image, opts[:larger_side])
    end

    manipulate({ src: src, dest: v1600x900, larger_side: 1600 }) do |image, opts|
      image = smart_rect image, 1600, 900, { repage: false }
      image
    end

    manipulate({ src: v1600x900, dest: v1280x720 }) do |image, opts|
      image = strict_resize image, 1280, 720
      image
    end
  end
end
```
