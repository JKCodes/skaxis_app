include ApplicationHelper

def full_title(page_title)
  base_title = "Skaxis"
  if page_title.empty?
    base_title
  else
    "#{base_title} - #{page_title}"
  end
end

def valid_login(user)
  fill_in "Email",    with: user.email.downcase
  fill_in "Password", with: user.password
  click_button "Log in"
end
 
