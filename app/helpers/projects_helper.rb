module ProjectsHelper
  
  def parse_wall_string(string)
    user_matches = string.scan(/@([a-zA-Z_0-9]+)/).flatten
    return string if user_matches.empty?
    User.find_all_by_short_name(user_matches).each do |user|
      string.gsub!("@#{user.short_name}", link_to("@#{user.short_name}", user_path(user.short_name)))
    end
    string
  end
  
  
end
