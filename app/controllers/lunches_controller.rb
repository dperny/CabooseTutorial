class MenuOptionsController < ApplicationController
  # GET /lunch
  def index
  end

  # GET /lunch/:id
  def show
    @option = Lunch.find(params[:id])
  end
  
  #===========================
  # Admin functions
  #===========================

  # GET /admin/lunch
  def admin_index
    # user_is_allowed is a Caboose::ApplicationController function
    # that checks to see if the user has the permission listed
    return if !user_is_allowed('lunch','view')

    # use Caboose's PageBarGenerator to build a selection menu
    @gen = Caboose::PageBarGenerator.new(params, {
      'name' => ''
    },{
      'model' => 'Lunch',
      'sort' => 'name',
      'desc' => false,
      'base_url' => '/admin/lunch'
    })
    @lunches = @gen.items
    # use Caboose's admin layout (as opposed to a modal layout)
    render :layout => 'caboose/admin'
  end

  # GET /admin/lunch/:id/edit
  def admin_edit
    return if !user_is_allowed('lunch','edit')
    @lunch = Lunch.find(params[:id])
    render :layout => 'caboose/admin'
  end

  # PUT /admin/lunch/:id
  def admin_update
    Caboose.log(params)
    return if !user_is_allowed('lunch','edit')

    resp = Caboose::StdClass.new({'attributes' => {}})
    lunch = Lunch.find(params[:id])

    save = true
    params.each do |name, value|
      lunch[name.to_sym] = value
    end

    resp.success = save && lunch.save
    render :json => resp
  end

  # GET /admin/lunch/new
  def admin_new
    return if !user_is_allowed('lunch','new')
    @lunch = Lunch.new
    render :layout => 'caboose/admin'
  end

  # POST /admin/lunch/
  def admin_create
    return if !user_is_allowed('lunch','new')

    resp = Caboose::StdClass.new({
      'error' => nil,
      'redirect' => nil
    })
    
    lunch = Lunch.new({
      :name = > params[:name]
    })

    if !lunch.save
      resp.error = "Couldn't save lunch option: #{lunch.errors.full_messages.join(', ')}"
    else
      resp.redirect = "/admin/lunch/#{lunch.id}/edit"
    end
    render json: resp
  end
end
