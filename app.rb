require 'ki'
require './lib/rhuba'

module Ki::Helpers
  def mega_hash
    Rhubarb.mega_hash
  end
end

class RhubarbUser < Ki::Model
  requires :email
  unique :email
end
