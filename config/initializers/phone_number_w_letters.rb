module PhoneNumberWithLetters

  DECODE_MAP = {}

  [ # ======================= #
       '1'  , '2abc' , '3def' ,
    # ======================= #
     '4ghi' , '5jkl' , '6mno' ,
    # ======================= #
     '7pqrs', '8tuv' , '9wxyz',
    # ======================= #
        '#' ,  '0'   ,  '*'   
  ].# ======================= #
  
  each do |button|
    number, *letters = button.split('')
    letters.each { |letter| DECODE_MAP[letter] = number }
  end
  
  DECODE_MAP.freeze

  class << self    
    def translate(phone_number)
      base_number, ext_number = split(phone_number)
      base_number = decode(base_number)
      [base_number, ext_number].join
    end
  
    def convert(phone_number, base = 11)
      base_number, ext_number = split(phone_number)
      base_number = decode(base_number)
      base_number = cut_off(base_number, base)
      [base_number, ext_number].join
    end
    
    def split(phone_number)
      phone_number.to_s.split(/(\s*e?xt?(?:ention)?\.?\s*\d{1,5}\s*)$/)
    end
    
    private
    
    def decode(base_number)
      base_number.to_s.split('').map{ |symbol| DECODE_MAP[symbol.downcase] || symbol }.join
    end 
        
    def cut_off(base_number, base)
      base_number[/(\d[^\d]*){#{base-1}}\d/] || base_number
    end
  end  
end
