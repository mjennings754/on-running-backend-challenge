class ApplicationController < ActionController::API
    before_action :authenticate_request

    private

    def authenticate_request
    header = request.headers['Authorization']
    if header.nil? || !header.start_with?('Bearer ')
        render json: { error: 'Missing or malformed token' }, status: :unauthorized
        return
    end

    token = header.split(' ').last
    decoded = JsonWebToken.decode(token)

    if decoded.nil?
        render json: { error: 'Invalid or expired token' }, status: :unauthorized
        return
    end
    end
end
