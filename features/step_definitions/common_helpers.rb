def ensure_on(url)
  visit url unless current_path == url
end
