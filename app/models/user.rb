class User < ActiveRecord::Base
  
  
  def self.from_omniauth(auth)
    where(email: auth.info.email.downcase).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      #user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.oauth_refresh_token = auth.credentials.refresh_token
      user.save!
    end
  end
  
  def refresh_token
    if oauth_expires_at < Time.now
      get_refresh_token
    end
    return oauth_refresh_token
  end
  
  
  protected
  
  def get_refresh_token
    client = Google::APIClient.new(:application_name => ENV["APPLICATION_NAME"], :application_version => ENV["APPLICATION_VERSION"] )
    token = OAuth2::AccessToken.from_hash client, self.attributes
    # self.access_token = token.refresh! if token.expired?
    self.oauth_token = token.refresh! if token.expired?
    self.save
    #refresh_post_hash = {'refresh_token' => oauth_refresh_token,
    #        'client_id' => ENV['GOOGLE_OAUTH2_ID'],
    #        'client_secret' => ENV['GOOGLE_OAUTH2_SECRET'],
    #        'grant_type' => 'refresh_token'}
    #url = URI("https://accounts.google.com/o/oauth2/token") 
    #response = Net::HTTP.post_form(url, refresh_post_hash)
    #refresh_hash = JSON.parse(response.body)
    #logger.debug(refresh_hash)
    #if refresh_hash['access_token'].blank?
    #  raise "no access token provided when refreshing"
    #else
    #  self.oauth_token = refresh_hash['access_token']
    #  self.oauth_expires_at = DateTime.now + refresh_hash["expires_in"].to_i.seconds
    #  self.save
    #end
  end
end
