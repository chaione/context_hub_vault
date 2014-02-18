require 'httparty'

module ContextHubVault
  class Client
    include HTTParty
    format :json

    def initialize(host: ContextHubVault.host, auth_token: ContextHubVault.auth_token, version: ContextHubVault.version, app_id: ContextHubVault.app_id)
      if http_prefix(host)
        self.class.base_uri "#{host}/api"
      else
        self.class.base_uri "https://#{host}/api"
      end
      self.class.headers('Authorization' => %Q[Token token="#{auth_token}"]) if auth_token
      self.class.headers('Accept' => "application/vnd.carbon.vault.v#{version}") if version
      self.class.headers('HTTP_CARBON_APP_ID' => app_id) if app_id
    end

    def find_by_id(id)
      search('vault_info.vault_id' => id).first
    end

    def search(query = {})
      get '/vaults', body: { query: query }
    end

    def create(container, data = {})
      fail 'Must include the container' unless container

      data.merge! container: container
      post '/vaults', body: data
    end

    def update(id, data = {})
      patch "/vaults/#{id}", body: data
    end

    def destroy(id, data = {})
      delete "/vaults/#{id}"
    end

    private

    def http_prefix(host)
      host.downcase.start_with?('http://', 'https://')
    end

    def post(path, options = {})
      self.class.post path, options
    end

    def get(path, options = {})
      self.class.get path, options
    end

    def patch(path, options = {})
      self.class.patch path, options
    end

    def delete(path, options = {})
      self.class.delete path, options
    end
  end
end
