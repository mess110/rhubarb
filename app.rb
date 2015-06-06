require './lib/req'

module Ki::Helpers
  def mega_hash
    Rhubarb.all
  end
end

class RhubarbUser < Ki::Model
  requires :email
  unique :email
  forbid :find, :update

  def before_create
    params[:created_at] = Time.now
  end
end
