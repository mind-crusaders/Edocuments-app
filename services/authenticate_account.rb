require 'http'

require 'http'

module Edocument
  # Returns an authenticated user, or nil
  class AuthenticateAccount
    class UnauthorizedError < StandardError; end

    def initialize(config)
      @config = config
    end

    def call(username:, password:)
      response = HTTP.post("#{@config.API_URL}/accounts/authenticate",
                           json: { username: username, password: password })

      raise(UnauthorizedError) unless response.code == 200
      response.parse
    end
  end
end

