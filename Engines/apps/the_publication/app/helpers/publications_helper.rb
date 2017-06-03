module PublicationsHelper
  def pubs_localized_date(date)
    return raw('&mdash;') unless date.present?
    date.to_rus_date_1
  end
end
