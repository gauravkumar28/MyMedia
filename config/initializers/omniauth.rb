OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '460995930902-la2eclaho6p25c1n8sa0idqcjuteumlo.apps.googleusercontent.com', '31Ge4AzOc7XhN1XswwTYqmtm', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end