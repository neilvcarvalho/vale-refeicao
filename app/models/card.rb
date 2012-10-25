class Card < ActiveRecord::Base
  belongs_to :user
  attr_accessible :number

  def inquiry
  	@busca ||= Inquiry.new(numero_vr: number)
  end
end
