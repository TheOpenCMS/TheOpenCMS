# include ::ThePublication::ControllerCustomViewRender
module ThePublication
  module ControllerCustomViewRender
    private

    def render_custom_view opts = {}
      opts = opts.with_indifferent_access

      layout = opts[:layout]
      template = opts[:template]

      if pub = opts[:publication]
        layout   = pub.view_layout   if pub.view_layout.present?
        template = pub.view_template if pub.view_template.present?
      end

      if layout.present? || template.present?
        render({ layout: layout, template: template }.compact)
      end
    end

  end # RenderCustomView
end
