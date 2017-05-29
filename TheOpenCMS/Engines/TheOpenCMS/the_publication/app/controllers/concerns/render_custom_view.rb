module ThePublication
  module RenderCustomView
    private

    def render_custom_view opts = {}
      opts = opts.with_indifferent_access

      template = opts[:default_template]
      layout = opts[:default_layout]
      pub = opts[:publication]

      if pub
        layout   = pub.view_layout   if pub.view_layout.present?
        template = pub.view_template if pub.view_template.present?
      end

      if layout.present? || template.present?
        render({ layout: layout, template: template }.compact)
      end
    end

  end # RenderCustomView
end
