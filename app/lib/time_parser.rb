module TimeParser
  def parsed_chronic_datetime(time)
    Chronic.parse(time).to_datetime
  end
end
