class Card < ActiveRecord::Base
  belongs_to :user
  attr_accessible :number

  def busca
  	@busca ||=Busca.new(numero_vr: number)
  end
end
