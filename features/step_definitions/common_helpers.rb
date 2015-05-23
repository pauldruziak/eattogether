def ensure_on(url)
  visit url unless current_path == url
end

def split_users_name(users_name)
  users_name.gsub(' та ', ', ').split(', ')
end
