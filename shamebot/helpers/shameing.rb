require_relative '../connection'

module ShameBot; module Data;
  class Shameing
    
    def initialize(args = {})
      @user = args[:user]   
      @reason = args[:reason]
      @connection = Connection.new
    end
    
    def add
      # return "#{@user} is not on the Wall of Shame" unless existing_user?
      @connection.write(user: @user, reason: @reason)
      "#{@user} added to the Wall of Shame for #{@reason}"
    end
    
    def existing_user?
      ShameBot::Data::Connection::USERS[@user.to_sym]
    end
    
  end
end; end