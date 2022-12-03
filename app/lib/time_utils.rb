# frozen_string_literal: true

module TimeUtils
  class << self
    def set_date_in_time(time, date)
      time.change(year: date.year, month: date.month, day: date.day)
    end

    def parse_time_of_day(time)
      time&.strftime('%I:%M%p %Z')
    end

    def set_zone_in_time(time, time_zone)
      ActiveSupport::TimeZone.new(time_zone).local_to_utc(time).in_time_zone(time_zone)
    end
  end
end
