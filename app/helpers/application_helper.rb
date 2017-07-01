module ApplicationHelper

  #ページごとのタイトルを設定
  def full_title(page_title = "")
    base_title = "Knowledge Stocker"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
