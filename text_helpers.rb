def dat_render(text)
  options = {
    :autolink => true,
    :space_after_headers => true,
    :no_intra_emphasis => true,
    :fenced_code_blocks => true,
    :hard_wrap  => true
  }
  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
  markdown.render(text).html_safe
end

def link_to(*args)
  text = args[0]
  dest = args[1]
  "<a href=\"#{dest}\">#{text}</a>"
end