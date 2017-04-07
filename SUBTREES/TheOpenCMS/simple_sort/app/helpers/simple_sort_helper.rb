module SimpleSortHelper
  def reset_simple_sort permitted_params = []
    simple_sort_params(permitted_params)
      .merge(sort_type: nil, sort_column: nil)
  end

  def simple_sort_url field, permitted_params = []
    sort_type = :asc

    if params[:sort_column] == field.to_s
      sort_type = { desc: :asc, asc: :desc }[ params[:sort_type].to_sym ]
    end

    url_for simple_sort_params(permitted_params)
      .merge(sort_column: field, sort_type: sort_type)
  end

  def simple_sort_params(permitted_params)
    return params.permit! if permitted_params.blank?
    params.permit(permitted_params)
  end
end
