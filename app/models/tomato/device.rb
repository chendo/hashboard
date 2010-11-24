class Tomato
  class Device
    attr_accessor :name, :ip, :mac, :lease_expires_in, :interface

    def lease_expires_in=(data)
      if data =~ /(\d) days?, (\d\d):(\d\d):(\d\d)/
        @lease_expires_in = $1.to_i.days + $2.to_i.hours + $3.to_i.minutes + $4.to_i
      else
        raise "Faiiiil"
      end
    end

    def lease_expires_at
      Time.at(Time.now + lease_expires_in)
    end

    def last_seen_at
      Time.at(Time.now - 7.days + lease_expires_in)
    end

  end
end