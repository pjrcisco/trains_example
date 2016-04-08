module Tropo

module Routes

  def self.base
    "https://api.tropo.com/1.0"
  end

  def self.sessions
    base + "/sessions"
  end

  def self.applications
    base + "/applications"
  end

  def self.exchanges
    base + "/exchanges"
  end
  
  def self.addresses
    base + "/addresses"
  end


end

end