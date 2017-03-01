require 'rest_client'
require 'json'
require 'pp'
#require_relative 'kele/errors.rb'

class Kele
  def initialize(email, password)
    values = {
      email: email,
      password: password
    }

    headers = {
      :content_type => 'application/json'
    }

    response = RestClient.post bloc_api("sessions"), values, headers
 #   raise InvalidStudentError.new() if response.code == 401
    @auth_token = JSON.parse(response.body)["auth_token"]
  end

  def get_me
    headers = {
      :content_type => 'application/json',
      :authorization => @auth_token
    }

    response = RestClient.get bloc_api("users/me"), headers
    @user_info = JSON.parse(response.body)
    @user_info.keys.each do |key|
      self.class.send(:define_method, key.to_sym) do
        @user_info[key]
      end
    end
    @user_info
  end

  def get_mentor_availability(id_of_mentor)
    headers = {
      :content_type => 'application/json',
      :authorization => @auth_token
    }

    response = RestClient.get bloc_api("mentors/#{id_of_mentor}/student_availability"), headers
    @mentor_availability = JSON.parse(response.body)
    pp @mentor_availability
  end

  def bloc_api(endpoint)
    "https://www.bloc.io/api/v1/#{endpoint}"
  end

end
