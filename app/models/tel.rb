class Tel
  PREFIXES = ["+8550", "8550", "+855", "855", "0", "+0", "+"]
  CHANNELS = 
    { "smart" => ["10", "15", "16", "69", "70", "81", "86", "87", "93", "96", "98"],
      "camgsm" => ["11", "12", "14", "17", "61", "76", "77", "78", "79", "85", "89", "92", "95", "99"],
      "metfone" => ["31", "60", "66", "67", "68", "71", "88", "90", "97"]
    }
  AREA_CODE_LENGTH = 2
  COUNTRY_CODE = "855"

  def initialize number
    @number = number
  end

  def without_prefix
    result = @number

    Tel::PREFIXES.each do |prefix|
      return @number[prefix.length..-1] if @number.start_with?(prefix)
    end
    @number
  end

  def with_country_code
    Tel::COUNTRY_CODE + self.without_prefix
  end

  def carrier
    header = without_prefix.slice(0, AREA_CODE_LENGTH)
    Tel::CHANNELS.each do |key, value|
      return key if value.include? header
    end
    
    nil
  end

  def equal? tel = nil
    return false if tel.nil?
    
    self.without_prefix == tel.without_prefix
  end

end
