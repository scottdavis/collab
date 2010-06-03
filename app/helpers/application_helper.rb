# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def csrf_meta_tag
    out = ''
    out << tag(:meta, :name => 'csrf-token', :content => form_authenticity_token)
    out << tag(:meta, :name => 'csrf-param', :content => 'authenticity_token')
  end
  
  def display_tags(tags)
    return if tags.blank?
    tags.map(&:to_s).join(", ")
  end
  
  def flashes
    out = ''
    flash.each_pair do |key, value|
      out << content_tag(:div, value, {:id => "flash_#{key}", :class => key})
    end
    content_tag(:div, out, {:id => "flashes"})
  end
  
  
  def tags(object)
    path = update_tags_path(object.class.name.downcase, object)
    tags = display_tags(object.tags)
    out = []
    out << javascript_include_tag('jeditable.min')
    out << "
    <script type='text/javascript'>
    	$(document).ready(function() {
    	    $('#tags').editable('#{path}', {col:'project'});
    	 });
    </script>
    <span id='tags'>
    	#{tags}
    </span>
    "
    out.join("\n")
  end
  
end
