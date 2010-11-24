class DevicesController < ApplicationController
  def index
    @devices = tomato.get_devices.values
  end

  private

  def tomato
    @tomato ||= Tomato.new(
      APP_CONFIG['router']['host'],
      APP_CONFIG['router']['username'],
      APP_CONFIG['router']['password']
    )
  end
end
