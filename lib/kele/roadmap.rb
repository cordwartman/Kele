module Roadmap
  def get_roadmap(roadmap_id)
    headers = {
      :content_type => 'application/json',
      :authorization => @auth_token
    }

    response = RestClient.get bloc_api("roadmaps/#{roadmap_id}"), headers
    @roadmap = JSON.parse(response.body)
    pp @roadmap
  end

  def get_checkpoint(checkpoint_id)
    headers = {
      :content_type => 'application/json',
      :authorization => @auth_token
    }

    response = RestClient.get bloc_api("checkpoints/#{checkpoint_id}"), headers
    @checkpoint = JSON.parse(response.body)
    pp @checkpoint
  end

end
