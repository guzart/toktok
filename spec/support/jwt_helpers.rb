# :reek:UtilityFunction
module JWTHelpers
  def find_signature(jwt)
    jwt.split('.').last
  end

  def apply_signature(jwt, signature)
    jwt.split('.').take(2).concat([signature]).join('.')
  end
end

RSpec.configure do |config|
  config.include JWTHelpers
end
