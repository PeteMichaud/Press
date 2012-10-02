module MarkdownHelper

  # Render markdown to html
  def render_markdown content, options = { }
    defaults = {
      # Which renderer are we going to use, XHTML or HTML?
      renderer:            Redcarpet::Render::XHTML,
      # Is there a query we need to highlight?
      query:               nil,
      # parse links even when they are not enclosed in `<>` characters. Autolinks for the http, https and ftp
      # protocols will be automatically detected. Email addresses are also handled, and http links without protocol, but
      # starting with `www.`
      autolink:            true,
      # A space is always required between the hash at the beginning of a header and its name, e.g. `#this is my header`
      # would not be a valid header.
      space_after_headers: true,
      # do not parse emphasis inside of words. Strings such as `foo_bar_baz` will not generate `<em> tags.
      no_intra_emphasis:   true,
      # parse strikethrough, PHP-Markdown style. Two `~` characters mark the start of a strikethrough,
      # e.g. `this is ~~good~~ bad`
      strikethrough:       true,
      # parse tables, PHP-Markdown style
      tables:              true,
      # parse fenced code blocks, PHP-Markdown style. Blocks delimited with 3 or more `~` or backticks will be considered
      # as code, without the need to be indented. An optional language name may be added at the end of the opening fence
      # for the code block
      fenced_code_blocks:  true,
      # parse superscripts after the `^` character; contiguous superscripts are nested together, and complex values can
      # be enclosed in parenthesis, e.g. `this is the 2^(nd) time`
      superscript:         true,
      # do not allow any user-inputted HTML in the output
      filter_html:         true,
      # do not generate any `<img>` tags
      no_images:           false,
      # do not generate any `<a>` tags
      no_links:            false,
      # do not generate any `<style>` tags
      no_styles:           true,
      # only generate links for protocols which are considered safe
      safe_links_only:     false,
      # add HTML anchors to each header in the output HTML, to allow linking to each section.
      with_toc_data:       false,
      # insert HTML `<br>` tags inside on paragraphs where the origin markdown document had newlines (by default,
      # markdown ignores these newlines).
      hard_wrap:           false,
      # like a database, limit the number of lines returned
      limit:               0
    }

    options = defaults.merge(options)

    # Instance the renderer using the options above
    renderer = options[:renderer].new options
    # Only use the content based on the limit
    content = content.split("\n")[0..(options[:limit]-1)].join if options[:limit] != 0
    # Instance Redcarpet with the options it knows above from above
    markdown = Redcarpet::Markdown.new renderer, options

    # Hit it!
    output = markdown.render(content)
    # okay now add the highlight filter for the query .. not ={query}
    output.gsub!(/[^=](#{options[:query]})/i, '<span class="highlight">\1</span>') if options[:query].present?

    output.html_safe
  end

end