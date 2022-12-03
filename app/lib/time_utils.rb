# frozen_string_literal: true

module TimeUtils
  class << self
    def set_date_in_time(time, date_or_date_string)
      date = date_or_date_string.is_a?(Date) ? date_or_date_string : Date.parse(date_or_date_string)
      time.change(year: date.year, month: date.month, day: date.day)
    end

    def parse_time_of_day(time)
      time&.strftime('%I:%M%p %Z')
    end

    def set_zone_in_time(time, time_zone)
      ActiveSupport::TimeZone.new(time_zone).local_to_utc(time)
    end
  end
end
