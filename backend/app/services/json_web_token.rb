class JsonWebToken
    SECRET = Rails.application.credentials.secret_key_base

    def self.encode(payload, exp = 24.hours.from_now)
        payload[:exp] = exp.to_i
        JWT.encode(payload, SECRET)
    end

    def self.decode(token)
    begin
        decoded = JWT.decode(token, SECRET)[0]
        HashWithIndifferentAccess.new(decoded)
    rescue JWT::DecodeError => e
        puts "JWT DECODE ERROR: #{e.message}"
        nil
    end
end
end