require 'kele/errors'
require 'kele/roadmap'
require 'kele/messages'
require 'rest_client'
require 'json'
require 'pp'

class Kele
  include Roadmap
  include Messages

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

  def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment, enrollment_id)
    values = {
      "assignment_branch" => assignment_branch,
      "assignment_commit_link" => assignment_commit_link,
      "checkpoint_id" => checkpoint_id,
      "comment" => comment,
      "enrollment_id" => enrollment_id
    }

    headers = {
      :content_type => 'application/json',
      :authorization => @auth_token
    }

    response = RestClient.post bloc_api("checkpoint_submissions"), values, headers
  end

  def bloc_api(endpoint)
    "https://www.bloc.io/api/v1/#{endpoint}"
  end

end
