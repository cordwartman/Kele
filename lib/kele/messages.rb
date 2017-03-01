module Messages
  def get_messages(page_num = nil)
    headers = {
      :content_type => 'application/json',
      :authorization => @auth_token
    }

    if page_num == nil
      response = RestClient.get bloc_api("message_threads"), headers
    else
      response = RestClient.get bloc_api("message_threads?page=#{page_num}"), headers
    end
    @messages = JSON.parse(response.body)
    pp @messages
  end

  def create_message(sender, recipient_id, subject, message, token = nil)
    values = {
      "sender" => sender,
      "recipient_id" => recipient_id,
      "token" => token,
      "subject" => subject,
      "stripped-text" => message
    }
    headers = {
      :content_type => 'application/json',
      :authorization => @auth_token
    }

    response = RestClient.post bloc_api("messages"), values, headers
    pp response
  end
end
