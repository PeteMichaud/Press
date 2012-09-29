module MarkdownHelper

  # Render markdown to html
  def render_markdown content, options = { }
    # Which rendere are we going to use, XHTML or HTML?
    options[:xhtml]               ||= true
    # Is there a query we need to highlight?
    options[:query]               ||= nil
    # parse links even when they are not enclosed in `<>` characters. Autolinks for the http, https and ftp
    # protocols will be automatically detected. Email addresses are also handled, and http links without protocol, but
    # starting with `www.`
    options[:autolink]            ||= true
    # A space is always required between the hash at the beginning of a header and its name, e.g. `#this is my header`
    # would not be a valid header.
    options[:space_after_headers] ||= true
    # do not parse emphasis inside of words. Strings such as `foo_bar_baz` will not generate `<em> tags.
    options[:no_intra_emphasis]   ||= true
    # parse strikethrough, PHP-Markdown style. Two `~` characters mark the start of a strikethrough,
    # e.g. `this is ~~good~~ bad`
    options[:strikethrough]       ||= true
    # parse tables, PHP-Markdown style
    options[:tables]              ||= true
    # parse fenced code blocks, PHP-Markdown style. Blocks delimited with 3 or more `~` or backticks will be considered
    # as code, without the need to be indented. An optional language name may be added at the end of the opening fence
    # for the code block
    options[:fenced_code_blocks]  ||= true
    # parse superscripts after the `^` character; contiguous superscripts are nested together, and complex values can
    # be enclosed in parenthesis, e.g. `this is the 2^(nd) time`
    options[:superscript]         ||= true
    # do not allow any user-inputted HTML in the output
    options[:filter_html]         ||= true
    # do not generate any `<img>` tags
    options[:no_images]           ||= false
    # do not generate any `<a>` tags
    options[:no_links]            ||= false
    # do not generate any `<style>` tags
    options[:no_styles]           ||= true
    # only generate links for protocols which are considered safe
    options[:safe_links_only]     ||= false
    # add HTML anchors to each header in the output HTML, to allow linking to each section.
    options[:with_toc_data]       ||= false
    # insert HTML `<br>` tags inside on paragraphs where the origin markdown document had newlines (by default,
    # markdown ignores these newlines).
    options[:hard_wrap]           ||= false

    renderer = options[:xhtml] ? Redcarpet::Render::XHTML : Redcarpet::Render::HTML
    renderer = renderer.new options

    content.gsub!(/(#{options[:query]})/i, '<span class="highlight">\1</span>') if options[:query].present?

    md = Redcarpet::Markdown.new renderer, options
    md.render(content).html_safe
  end

end