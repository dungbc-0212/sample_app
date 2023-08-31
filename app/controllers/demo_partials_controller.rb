class DemoPartialsController < ApplicationController
  def new
    @zone = "Zone New action"
    @date = Date.today
  end

  def edit
    @zone = "Zone edit action"
    @date = Date.today
  end
end
