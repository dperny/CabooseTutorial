class BlogPostController < ApplicationController

  def index
    # I feel certain that this should do something?
  end

  # GET blog_post/:id
  def show
    @blog_post = Blog_Post.find(params[:id])
  end

  # GET blog_post/new
  def new
    return if !user_is_allowed('blog_post','add')

    # create a new blog post
    @blog_post = Blog_Post.new
    # render a caboose/admin style layout for our page
    render :layout => 'caboose/admin'
  end

  # POST blog_post
  def create
    return if !user_is_allowed('blog_post','add')

    # create a new response class
    resp = Caboose::StdClass.new({
      'error' => nil,
      'redirect' => nil
    })
    
    # create a new post with the parameters passed in
    post = Blog_Post.new({
      :title => params[:title]
      :content => params[:content]
      :author => params[:author]
    })

    # make sure we can save it
    if !Blog_Post.save
      # return an error if not
      resp.error = "Couldn't save post: #{post.errors.full_messages.join(', ')}"
    else
      # show the post if it does save
      resp.redirect = "blog_post/:id"
    end
    render json: resp
  end

  # GET blog_post/:id/edit
  def edit
    return if !user_is_allowed('blog_post','edit')

    # get the blog post we want to edit
    @blog_post = Blog_Post.find(params[:id])
    # use a caboose admin layout
    render :layout => 'caboose/admin'
  end

  # PUT blog_post/:id
  def update
    Caboose.log(params)
    return if !user_is_allowed('blog_post','edit')

    resp = Caboose::StdClass.new({'attributes' => {}})
    blog_post = Blog_Post.find(params[:id])

    save = true
    params.each do |name,value|
      blog_post[name.to_sym] = value
    end
    resp.success = save && blog_post.save
    render :json => resp
  end

  # DELETE blog_post/:id
  def delete
  end
end
