module ApplicationHelper
  def full_tittle(page_name = "")
    base_title = "AttendanceApp"
    if page_name.empty?
      base_title
    else
      page_name + "|" + base_title
    end
  end
end
