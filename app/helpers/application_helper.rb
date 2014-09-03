module ApplicationHelper

  def markdown(content)
    markdown =Redcarpet::Markdown.new(Redcarpet::Render::HTML,:hard_wrap=>true,:filter_html=>true,:autolink=>true,:no_intra_emphasis=>true)
    markdown.render(content).html_safe
  end
end
