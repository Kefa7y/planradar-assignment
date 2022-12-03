# frozen_string_literal: true

module TimeUtils
  class << self
    def set_date_in_time(time, date_or_date_string)
      date = date_or_date_string.is_a?(Date) ? date_or_date_string : Date.parse(date_or_date_string)
      time.change(year: date.year, month: date.month, day: date.day)
    end
  end
end
