if ["development", "test"].include? ENV["RAILS_ENV"]
  Dotenv::Railtie.load
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV["GITHUB_CLIENT_ID"], ENV["GITHUB_CLIENT_SECRET"], scope: "user:email"
end
