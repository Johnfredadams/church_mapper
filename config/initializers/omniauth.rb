OmniAuth.config.logger = Rails.logger  


Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_OAUTH2_ID'], ENV['GOOGLE_OAUTH2_SECRET'], {application_name: ENV['APPLICATION_NAME'], application_version: ENV['APPLICATION_VERSION'], scope: 'userinfo.email,userinfo.profile,calendar', access_type: 'online', prompt: 'select_account',client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
  provider :microsoft_live, ENV['MICROSOFT_LIVE_KEY'], ENV['MICROSOFT_LIVE_SECRET'], {application_name: ENV['APPLICATION_NAME'], application_version: ENV['APPLICATION_VERSION'], scope: 'wl.basic,wl.emails'}
  provider :windowslive, ENV['MICROSOFT_LIVE_KEY'], ENV['MICROSOFT_LIVE_SECRET'], {application_name: ENV['APPLICATION_NAME'], application_version: ENV['APPLICATION_VERSION'], scope: 'wl.basic,wl.emails'}
  provider :amazon, ENV['AWS_ID_KEY'], ENV['AWS_ID_SECRET'], {application_name: ENV['APPLICATION_NAME'], application_version: ENV['APPLICATION_VERSION']}
end


# thrown this in here to overwrite omniauth strategy


require "oauth2"
require "omniauth"
require "securerandom"
require "socket"       # for SocketError
require "timeout"      # for Timeout::Error

module OmniAuth
  module Strategy # rubocop:disable ModuleLength

     def full_host
       case OmniAuth.config.full_host
       when String
         OmniAuth.config.full_host
       when Proc
         OmniAuth.config.full_host.call(env)
       else
         # in Rack 1.3.x, request.url explodes if scheme is nil
         if request.scheme && request.url.match(URI::ABS_URI)
           uri = URI.parse(request.url.gsub(/\?.*$/, ''))
           uri.path = ''
           # sometimes the url is actually showing http inside rails because the
           # other layers (like nginx) have handled the ssl termination.
           uri.scheme = 'https' if ssl? # rubocop:disable BlockNesting
           uri.to_s
         else ''
         end
       end
     end



   end

  module Strategies
    # Authentication strategy for connecting with APIs constructed using
    # the [OAuth 2.0 Specification](http://tools.ietf.org/html/draft-ietf-oauth-v2-10).
    # You must generally register your application with the provider and
    # utilize an application id and secret in order to authenticate using
    # OAuth 2.0.
    class OAuth2
      include OmniAuth::Strategy
      
      def callback_url
        ENV["OAUTH_CALLBACK_HOST"] + script_name + callback_path + query_string
      end
      
      
      def callback_phase # rubocop:disable AbcSize, CyclomaticComplexity, MethodLength, PerceivedComplexity
        error = request.params["error_reason"] || request.params["error"]
        if error
          fail!(error, CallbackError.new(request.params["error"], request.params["error_description"] || request.params["error_reason"], request.params["error_uri"]))
        elsif (session["omniauth.origin"].present? && request.host == URI.parse(session["omniauth.origin"]).host) && !options.provider_ignores_state && (request.params["state"].to_s.empty? || request.params["state"] != session.delete("omniauth.state"))
          fail!(:csrf_detected, CallbackError.new(:csrf_detected, "CSRF detected"))
        else
          self.access_token = build_access_token
          self.access_token = access_token.refresh! if access_token.expired?
          super
        end
      rescue ::OAuth2::Error, CallbackError => e
        fail!(:invalid_credentials, e)
      rescue ::Timeout::Error, ::Errno::ETIMEDOUT => e
        fail!(:timeout, e)
      rescue ::SocketError => e
        fail!(:failed_to_connect, e)
      end

    end
  end
end