require 'net/http'
require 'json'
require File.dirname(__FILE__) + "/tomato/device"

class Tomato
  attr_accessor :session_id, :host, :username, :password
  
  def initialize(host, username = 'root', password = 'admin')
    @host = host
    @username = username
    @password = password
  end

  def get_devices
    ret = post('devlist')
    device_map = Hash.new { |h, k| h[k] = Device.new }
    ret[:arplist].each do |d|
      ip, mac, interface = *d

      dev = device_map[mac]
      dev.mac = mac
      dev.ip = ip
      dev.interface = interface
    end

    ret[:dhcpd_lease].each do |d|
      name, ip, mac, expires_in = *d

      dev = device_map[mac]
      dev.mac = mac
      dev.name = name
      dev.lease_expires_in = expires_in
      dev.ip = ip
      
    end
    device_map
  end

  private

  def http
    @http ||= Net::HTTP.new(host)
  end

  def req(request)
    http.request(request)
  end

  def session_id
    @session_id ||= begin
      req = Net::HTTP::Get.new('/')
      req.basic_auth(username, password)
      http.request(req).body.match(/_http_id=(TID[a-f0-9]+)/)[1]
    end
  end

  def post(exec)
    @post_req ||= begin
      r = Net::HTTP::Post.new('/update.cgi')
      r.basic_auth(username, password)
      r
    end

    @post_req.set_form_data({'exec' => exec,
                            '_http_id' => session_id})

    res = req(@post_req)
    str = res.body

    data = {}
    str.split(/\n+/).reject { |l| l.strip == '' }.each do |line|
      line.gsub!(/^(\w+)\s*=\s*/, '')
      data[$1.to_sym] = eval(line)
    end
    data
  end
end
