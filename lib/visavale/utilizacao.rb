module VisaVale
	class Utilizacao

		attr_accessor :data, :local, :valor

		def initialize(tr)
			data  = tr.css('td')[0]
			local = tr.css('td')[1]
			valor = tr.css('td')[2]
		end

		def data=(data)
			ult_recarga = doc.css('table.consulta')[0].css('tr.rowTable')[2].css('td')[1].content
			ult_recarga = Date.strptime(ult_recarga.concat("/#{Time.now.year.to_s}"),"%d/%m/%Y") if ult_recarga
			ult_recarga = ult_recarga - 1.year if ult_recarga && ult_recarga > Time.now.to_date
			self.data   = ult_recarga
		end

		def valor=(valor)
			self.valor = valor.gsub(",",".").to_f
		end

	end
end