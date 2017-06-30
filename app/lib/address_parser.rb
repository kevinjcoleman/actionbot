module AddressParser
  def parse_address(address_line)
    address = StreetAddress::US.parse(address_line)
    raise "Address cannot be parsed" unless address
    address
  end
end
