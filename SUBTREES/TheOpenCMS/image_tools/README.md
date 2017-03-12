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

The MIT License (MIT)

Copyright (c) 2014-[Current Year] Ilya N. Zykin (https://github.com/the-teacher)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
