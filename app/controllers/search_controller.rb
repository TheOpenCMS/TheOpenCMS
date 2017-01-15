class SearchController < ApplicationController
  def search
    @q = params[:q].to_s.strip
    to_search = ::Riddle::Query.escape @q

    @notes = ::ThinkingSphinx.search(
      to_search,
      star: true,
      classes: [ Note ],
      field_weights: {
        title: 5,
        content: 3
      },
      per_page: 24
    )
    .page(params[:page])
    .per(params[:per_page])
  end
end
