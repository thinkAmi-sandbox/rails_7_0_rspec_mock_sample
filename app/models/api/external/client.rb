class Api::External::Client
  def self.twitter
    @twitter ||= Api::External::Twitter.new
  end
end