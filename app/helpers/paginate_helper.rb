module PaginateHelper
  def build_pagination(arg)
    paginate arg, theme: 'bootstrap-5',
    pagination_class: "pagination-sm mt-1 flex-wrap justify-content-center",
    nav_class: "d-inline-block"
  end
end