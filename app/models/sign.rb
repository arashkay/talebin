class Sign
  
  def self.all
    [ 
      nil,
      { :month => '1' , :name => 'فروردين' ,:ar => 'حمل',:fa => 'بره' },
      { :month => '2' , :name => 'اردیبهشت' ,:ar => 'ثور',:fa => 'گاو نر' },
      { :month => '3' , :name => 'خرداد' ,:ar => 'جوزا',:fa => 'دو پيكر' },
      { :month => '4' , :name => 'تير' ,:ar => 'سرطان',:fa => 'خرچنگ' },
      { :month => '5' , :name => 'مرداد' ,:ar => 'اسد',:fa => 'شير' },
      { :month => '6' , :name => 'شهريور' ,:ar => 'سنبله',:fa => 'خوشه' },
      { :month => '7' , :name => 'مهر' ,:ar => 'ميزان',:fa => 'ترازو' },
      { :month => '8' , :name => 'آبان' ,:ar => 'عقرب',:fa => 'كژدم' },
      { :month => '9' , :name => 'آذر' ,:ar => 'قوس',:fa => 'كمان' },
      { :month => '10' , :name => 'دى' ,:ar => 'جدي',:fa => 'بزغاله' },
      { :month => '11' , :name => 'بهمن' ,:ar => 'دلو',:fa => 'سطل آب' },
      { :month => '12' , :name => 'اسفند' ,:ar => 'هوت',:fa => 'ماهي' }
    ]
  end

  def self.fa(id)
    Sign.all[id][:fa]
  end

  def self.ar(id)
    Sign.all[id][:ar]
  end
end
