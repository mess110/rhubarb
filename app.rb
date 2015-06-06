require './lib/req'

class RhubarbUser < Ki::Model
  requires :email
  unique :email
  forbid :find, :update

  def before_create
    params[:created_at] = Time.now
  end
end

class RhubarbItem < Ki::Model
  requires :title, :start_date, :end_date
  unique :title
  forbid :update, :create, :delete

  def before_create
    params[:created_at] = Time.now
  end
end
