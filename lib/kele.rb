require 'httparty'

class Kele
  include HTTParty
  
  def initialize(email, password)
    @bloc_api = 'https://private-anon-9166bbd7c2-blocapi.apiary-mock.com/api/v1/sessions'
    @user_auth_token = self.class.post(@bloc_api, body: {email: email, password: password})
  end
end

  
