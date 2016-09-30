class Google::ServiceAccount  
  def initialize(person: nil, scopes:)
    @person = person
    @scopes = scopes
  end

  def authorized_client
    @authorized_client ||= Google::APIClient.new(:application_name => ENV["APPLICATION_NAME"], :application_version => ENV["APPLICATION_VERSION"] ).tap do |api_client|
      api_client.authorization = Signet::OAuth2::Client.new(client_secret)
      api_client.authorization.fetch_access_token!
    end
  end

private  
  attr_reader :person

  def signing_key
    # This oddity is because I'm using Heroku and storing the secret key as string ENV variable
    @signing_key ||=  OpenSSL::PKey::RSA.new(Google::Auth::ServiceAccountCredentials.read_json_key(StringIO.new(ENV["GOOGLE_SERVICE_ACCOUNT_CREDENTIALS"]))[0])
  end

  def scopes
    Array(@scopes).join(" ")
  end

  def client_secret
    {
      signing_key: signing_key,
      token_credential_uri: "https://accounts.google.com/o/oauth2/token",
      audience: "https://accounts.google.com/o/oauth2/token",
      issuer: Google::Auth::ServiceAccountCredentials.read_json_key(StringIO.new(ENV["GOOGLE_SERVICE_ACCOUNT_CREDENTIALS"]))[1],
      scope: scopes
     }
  end

end 