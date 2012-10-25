# encoding: utf-8

class CardUse

	attr_accessor :data, :local, :valor, :tr

	def initialize(tr)
		@tr = tr
		data  = tr.css('td')[0].content
		local = tr.css('td')[1].content
		valor = tr.css('td')[2].content
	end

	def date
		Date.strptime(tr.css('td')[0].content, '%d/%m')
	end

	def place
		tr.css('td')[1].content
	end

	def value
		tr.css('td')[2].content.gsub(/\D/, '').to_f/100
	end

end