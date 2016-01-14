module ApplicationHelper

  # Returns the full title based on a specific page
  def full_title(page_title = '')
    base_title = "Skaxis"
    if page_title.empty?
      base_title
    else
      "#{base_title} - #{page_title}"
    end
  end
end
