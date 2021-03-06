class Admin::ContentController < AdminController

  # LIST -- Shows a list of the content type [posts,pages,comments,messages,ads,etc...]
  def index
    # Set our limit, this should be dynamic or something.. drop box?
    limit = 12

    # if we are talking about a tag, get our posts from there
    #@tag = params[:tag] || ''
    #if @tag.present?
    #  tag = Taxonomy.find_by_seo_url @tag
    #  @posts = list_models tag.posts, [], 'go_live desc' if params[:type] == 'posts'
    #end

    # If we are talking about a category get the posts from there
    #@category = params[:category] || ''
    #if @category.present?
    #  category = Taxonomy.find_by_seo_url @category
    #  @posts = list_models category.posts, [], 'go_live desc' if params[:type] == 'posts'
    #end


    @posts = PostDecorator.decorate(list_models Post.send(params[:type]), [], 'go_live desc')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # EDIT -- Figure out which content type we are talking about and edit that one using it's restful path.
  # Note this could be done entirely in the routes file but I just incase I needed more I did it here.
  def edit
    case params[:type]
      when "post"
        redirect_to edit_admin_post_path params[:id]
      when "page"
        redirect_to edit_admin_page_path params[:id]
      else
        redirect_to admin_content_index_path :type
    end
  end

end
