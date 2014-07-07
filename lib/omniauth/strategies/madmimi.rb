require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Madmimi < OmniAuth::Strategies::OAuth2
      option :name, "madmimi"

      option :client_options, { site: "https://madmimi.com" }

      uid { raw_info["id"] }

      info do
        {
          "name"  => raw_info["name"],
          "email" => raw_info["email"]
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/apiv2/user').parsed || {}
      end
    end
  end
end
