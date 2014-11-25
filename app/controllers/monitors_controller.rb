class MonitorsController < ApplicationController
  include ResquesMonitor

  def show_apis
    @resque_data = ResquesMonitor.get_resque_data(ResqueMonitor.config.api_hosts)
    render action: :index
  end

  def show_collectors
    @resque_data = ResquesMonitor.get_resque_data(ResqueMonitor.config.collector_hosts)
    render action: :index
  end
end
