class DashboardController < ApplicationController
  include TicketsCountable

  before_action :authenticate_user!, only: :index
  before_action :tickets_by_priority_totals, only: :index
  before_action :tickets_by_status_totals, only: :index

  def index
  end
end
