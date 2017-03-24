Premailer::Rails.config.merge!(
  preserve_styles: true,
  remove_classes: !Rails.env.development?,
  remove_ids: true
)
