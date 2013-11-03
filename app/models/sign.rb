class Sign
  
  def self.all
    [ 
      nil,
      I18n.t('months')[1],
      I18n.t('months')[2],
      I18n.t('months')[3],
      I18n.t('months')[4],
      I18n.t('months')[5],
      I18n.t('months')[6],
      I18n.t('months')[7],
      I18n.t('months')[8],
      I18n.t('months')[9],
      I18n.t('months')[10],
      I18n.t('months')[11],
      I18n.t('months')[12]
    ]
  end

  def self.fa(id)
    Sign.all[id][:fa]
  end

  def self.ar(id)
    Sign.all[id][:ar]
  end
end
