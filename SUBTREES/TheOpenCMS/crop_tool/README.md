```ruby
This gem is a part of TheOpenCMS project. https://github.com/TheOpenCMS
```

# CropTool

```json
{
  "name": "MyApp",
  "dependencies": {
    "jquery-jcrop": "=0.9.13"
  }
}
```

```sh
yarn install
```

**application.html.slim**

```ruby
= yield :crop_tool
```

**CSS**

```css
//= require ptz/reset
//= require ptz/base
//= require ptz/framework
//= require ptz/inputs_buttons/all
```

and

```css
//= require crop_tool/crop_tool
//= require jquery-jcrop/css/jquery.Jcrop
```

or

```css
//= require crop_tool/crop_tool
//= require crop_tool/jcrop/jquery.Jcrop
```

**JS**

```coffee
#= require crop_tool/crop_tool
#= require jquery-jcrop/js/jquery.Jcrop
```

or

```coffee
#= require crop_tool/crop_tool
#= require crop_tool/jcrop/jquery.Jcrop
```

```coffee
$ ->
  do CropTool.init
```

**routes.rb**

```ruby
  resources :products do
    member do
      patch  :main_image_crop_base
      patch  :main_image_crop_preview
      patch  :main_image_rotate
      delete :main_image_delete
    end
  end
```

**Model**

```ruby
class Product < ActiveRecord::Base
  def main_image_crop_base params
    crop_params = params[:crop].symbolize_keys

    src  = main_image.path
    dest = main_image.path :base

    manipulate({ src: src, dest: dest }.merge(crop_params)) do |image, opts|
      scale = image[:width].to_f / opts[:img_w].to_f
      image = crop image, opts[:x], opts[:y], opts[:w], opts[:h], scale
      image = strict_resize image, 270, 210
      image
    end

    main_image.url(:base, timestamp: false)
  end

  def main_image_crop_preview params
    crop_params = params[:crop].symbolize_keys

    src  = main_image.path
    dest = main_image.path :preview

    manipulate({ src: src, dest: dest }.merge(crop_params)) do |image, opts|
      scale = image[:width].to_f / opts[:img_w].to_f
      image = crop image, opts[:x], opts[:y], opts[:w], opts[:h], scale
      image = strict_resize image, 100, 100
      image
    end

    main_image.url(:preview, timestamp: false)
  end

  def main_image_rotate
    return false unless main_image?

    src     = main_image.path
    base    = main_image.path :base
    preview = main_image.path :preview

    [src, base, preview].each do |image_path|
      manipulate({ src: image_path, dest: image_path }) do |image, opts|
        rotate_right image
      end
    end
  end

  def main_image_destroy!
    base    = main_image.path(:base).to_s
    preview = main_image.path(:preview).to_s

    destroy_file [base, preview]
    main_image.destroy

    save!
  end
end
```

**Controller**

```ruby
class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product

  def main_image_crop_base
    path = @product.main_image_crop_base(params)
    render json: { ids: { main_image_base_pic: path } }
  end

  def main_image_crop_preview
    path = @product.main_image_crop_preview(params)
    render json: { ids: { main_image_preview_pic: path } }
  end

  def main_image_rotate
    @product.main_image_rotate
    redirect_to :back
  end

  def main_image_delete
    @product.main_image_destroy!
    redirect_to :back
  end
end
```

**Views**

```slim
  ruby:
    crop_data_base = {
      url:   url_for([:main_image_crop_base, object]),
      source: object.main_image.url(:original),
      holder:  { width: 500 },
      preview: { width: 270, height: 210 },
      final_size: "270x210",
      callback_handler: "CropTool.pub_main_image_crop"
    }

    crop_data_preview = {
      url:   url_for([:main_image_crop_preview, object]),
      source: object.main_image.url(:original),
      holder:  { width: 500 },
      preview: { width: 100, height: 100 },
      final_size: "100x100",
      callback_handler: "CropTool.pub_main_image_crop"
    }

  = link_to "Crop 270x210", "#", class: "js_crop_tool", data: crop_data_base
  = link_to "Crop 100x100", "#", class: "js_crop_tool", data: crop_data_preview
  = link_to 'Rotate', [:main_image_rotate, object], method: :patch
```

### The MIT License (MIT)

Copyright (c) 2014-[Current Year] Ilya N. Zykin (https://github.com/the-teacher)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
