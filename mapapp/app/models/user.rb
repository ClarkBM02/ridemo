class User < ActiveRecord::Base

  attr_accessible :first, :last

   validates :first,  :presence => true,
                    :length   => { :maximum => 25 }
   validates :last,  :presence => true,
                    :length   => { :maximum => 25 }

         validates :tagID, :length => { :maximum => 3}

  validates :longitude, :length => {:maximum => 180,
                                    }


  validates :latitude, :length => {:maximum => 90,
                                    }



end
