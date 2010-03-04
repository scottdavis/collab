# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def csrf_meta_tag
    out = ''
    out << tag(:meta, :name => 'csrf-token', :content => form_authenticity_token)
    out << tag(:meta, :name => 'csrf-param', :content => 'authenticity_token')
  end
  
end
