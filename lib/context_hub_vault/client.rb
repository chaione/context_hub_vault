require 'httparty'

module ContextHubVault
  class Client
    include HTTParty
    format :json

    %i[post get patch delete].each do |verb|
      define_method(verb) do |path, options = {}|
        self.class.send(verb, path, options)
      end
      private verb
    end

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

    # Find a vault by it's vault_id
    #
    # @param id [String] vault_id
    # @return [Hash] The full vault data structure that matches the vault_id
    def find_by_id(id)
      search('vault_info.vault_id' => id).first
    end

    # Search the vault for items that match your query params
    #
    # @param query [Hash] search by keyword
    # @param query [String] javascript language search
    # @return [Array] An array of the matching search results
    def search(query = {})
      get '/vaults', body: { query: query }
    end

    # Create new vault data
    #
    # @param container [String] The name of the vault container
    # @param data [Hash] A hash of key/value pairs to store in the vault
    # @return [Hash] The newly created vault
    def create(container, data = {})
      fail 'Must include the container' unless container

      data.merge! container: container
      post '/vaults', body: data
    end

    # Update vault data
    #
    # @param id [String] vault_id
    # @param data [Hash] Data to update the vault with
    # @return [Hash] The updated vault data structure
    def update(id, data = {})
      patch "/vaults/#{id}", body: data
    end

    # Delete a vault by vault_id
    #
    # @param id [String] vault_id
    def destroy(id, data = {})
      delete "/vaults/#{id}"
    end

    private

    def http_prefix(host)
      host.downcase.start_with?('http://', 'https://')
    end
  end
end
