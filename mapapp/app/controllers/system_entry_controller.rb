class SystemEntryController < ApplicationController
  include Geokit::Geocoders

  def new

  end

  def useroptions
    @res1 = MultiGeocoder.geocode('528 Wilcox St, Fort Atkinson, WI 53538')

    if cookies[:user_id] != nil
        @user = User.where(:id => cookies[:user_id].to_i)
        if @user != nil
          session[:uid] = cookies[:user_id]

        end

    end
  end

  def map
    @users = User.all


  end
end
