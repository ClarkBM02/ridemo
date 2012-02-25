class UsersController < ApplicationController
  include Geokit::Geocoders

  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end

    if request.post?
              @user = User.new(params[:user])


             if @user.save != nil
             session[:uid] = @user.id.to_s

              #  create cookies
              cookies[:user_id] = {:value => @user.id.to_s, :expires => Time.now + 30000}
              cookies[:user_first] = {:value => params[:user][:first], :expires => Time.now + 30000}
              cookies[:user_last] = {:value => params[:user][:last], :expires => Time.now + 30000}

             if params[:user][:city] != nil
               @res = MultiGeocoder.geocode(params[:user][:city])
               @user.latitude = @res.lat
              @user.longitude = @res.lng

             end
               if params[:user][:ip] != nil
                 @res = Multigeocoder.geocode(params[:user][:ip])
               params[:user][:latitude]= @res.lat
               params[:user][:longitude] = @res.lng
               end

              @tempuser = User.find(params[:id])
              @tempuser.update_attributes(@user)

              redirect_to :action => "useroptions"
              return

        end
       end
  end

  # GET /users/1/edit
  def edit
    @user = User.where(:id => cookies[:user_id].to_i)
        if @user != nil
          @user = User.find(params[:id])
        else
          cookies[:user_id] = nil
          end
  end

  # POST /users
  # POST /users.json
  def create
    @ran1 = rand(10)
    @ran2 = rand(10)
    @ran3 = rand(10)
    @ran4 = rand(10)
    session[:random_num] = (((@ran1*1000)+(@ran2*100)+(@ran3*10)+@ran4)).to_s

    @user = User.new(params[:user])


     session[:captcha_in] = params[:captcha_in]

    if session[:captcha_in] == session[:random_num]
    respond_to do |format|
      if @user.save
        session[:uid] = @user.id.to_s

              #  create cookies
              cookies[:user_id] = {:value => @user.id.to_s, :expires => Time.now + 30000}
              cookies[:user_first] = {:value => params[:user][:first], :expires => Time.now + 30000}
              cookies[:user_last] = {:value => params[:user][:last], :expires => Time.now + 30000}
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
    else
       format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
   end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end
end
