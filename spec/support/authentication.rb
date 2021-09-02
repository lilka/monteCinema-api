# frozen_string_literal: true

def login(current_user)
  post '/auth/sign_in', params: { email: current_user.email, password: 'password' }.to_json,
                        headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
end

def fetch_auth_params_from_login(response)
  {
    'access-token' => response.headers['access-token'],
    'client' => response.headers['client'],
    'uid' => response.headers['uid'],
    'expiry' => response.headers['expiry'],
    'token-type' => response.headers['token-type']
  }
end
