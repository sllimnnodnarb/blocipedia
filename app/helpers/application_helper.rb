module ApplicationHelper
  def form_group_tag(errors, &block)
    css_class = 'form-group'
    css_class << ' has-error' if errors.any?
    content_tag :div, capture(&block), class: css_class
  end

  def avatar_url(user)
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=48"
  end

  def markdown(text)
    render_options = {
      filter_html:     true,
      hard_wrap:       true,
      autolink:        true,
      link_attributes: { rel: 'nofollow' }
    }

    extensions = {
      fenced_code_blocks: true,
      lax_spacing:        true,
      no_intra_emphasis:  true,
      strikethrough:      true,
      superscript:        true
    }

    renderer = Redcarpet::Render::HTML.new(render_options)
    markdown =
    Redcarpet::Markdown.new(renderer, extensions).render(text).html_safe
  end
end
