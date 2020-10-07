module ProjectsHelper
  def format_status(status)
    if status.include?("_")
      status.downcase.tr!("_", " ").titleize
    else
      return status.titleize
    end
  end
end
