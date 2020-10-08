class DashboardController < ApplicationController
  include TicketsCountable

  before_action :authenticate_user!, only: :index
  before_action :tickets_by_status, only: :index
  before_action :tickets_by_priority, only: :index

  def index
  end
end
