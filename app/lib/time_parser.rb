module TimeParser
  def parsed_chronic_datetime(time)
    parsed_time = Chronic.parse(time)
    raise "cannot read the given time" unless parsed_time
    parsed_time.to_datetime
  end
end
