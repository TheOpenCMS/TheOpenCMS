module RequirejsHelper
  def require_js_include_tag base_js_file, data_js_file
    javascript_include_tag base_js_file, 'data-main' => javascript_path(data_js_file)
  end

  def require_js_asset asset_name, asset_file_name
    file_name = javascript_path(asset_file_name)[0..-4]

    javascript_tag do
      js = <<-HEREDOC
        window.REQUIRE_ASSETS = window.REQUIRE_ASSETS || {};
        window.REQUIRE_ASSETS.js = window.REQUIRE_ASSETS.js || {};
        window.REQUIRE_ASSETS.js['#{asset_name}'] = '#{file_name}';
      HEREDOC

      js.html_safe
    end
  end
end
