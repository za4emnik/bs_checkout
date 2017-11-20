module ApplicationHelper
  def show_errors(obj, field)
    obj.errors[field].join(', ')
  end

  def add_error_class(obj, field)
    'has-error' if obj.errors[field].any?
  end
end
