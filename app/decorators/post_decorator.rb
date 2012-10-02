class PostDecorator < Draper::Base
  decorates :post

  def render opts = {preview: false}
    unless opts[:preview]
      h.render :partial => "posts/#{object_type}", :locals => { :"#{object_type}" => self }
    else
      h.render :partial => "posts/#{object_type}_preview", :locals => { :"#{object_type}" => self }
    end
  end

  def nav
    h.render :partial => 'posts/post_nav.html.erb'
  end

  def read_more_link
    if body.present?
      h.content_tag :div, :class => 'readmore' do
        h.link_to 'Read more...', full_url
      end
    end
  end

  def header query = nil
    super.gsub! '()', "(%s)" % h.url_for("/#{post.seo_url}/#{query}")
  end

  def full_url query = nil
    "/#{seo_url}/#{query}"
  end

  def edit_link
    if h.current_user == user
      nav_item do
        h.link_to '<i class="icon-pencil"></i>Edit'.html_safe, h.edit_admin_content_path(object_type, self)
      end
    end
  end

  def comments_link
    if allow_comments
      nav_item do
        h.link_to "<i class='icon-comment'></i>Comments (#{comments.count})".html_safe, "#{full_url}#comments"
      end
    end
  end

  def nav_item
    h.content_tag :li, :class => 'pull-right' do
      yield
    end
  end

  def nav_bar
    h.content_tag :div, :class => 'navbar' do
      h.content_tag :div, :class => 'navbar-inner' do
        h.content_tag :ul, :class => 'nav' do
          yield
        end
      end
    end
  end

  def render_taxonomies type
    tax_list = send(type)
    tax_list.each do |tax|
      render_taxonomy tax, tax == tax_list.first
    end
  end

  def render_taxonomy tax, current = false
    h.render :partial => 'taxonomies/taxonomy', :locals => { :t => tax, :current => current }
  end

end
