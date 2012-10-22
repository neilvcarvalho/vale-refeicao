# encoding: utf-8
require "nokogiri"
require 'open-uri'
# require 'utilizacao'

module VisaVale
	class Busca
		attr_accessor :valor, :quantia, :data_input, :entrada, :utilizacoes, :ja_almocou
		def initialize(params)
			numero_vr = params[:numero_vr]

			doc = Nokogiri::HTML(open("http://www.cartoesbeneficio.com.br/inst/convivencia/SaldoExtrato.jsp?numeroCartao=#{numero_vr}"))

			ult_utilizacao, ult_recarga, prox_recarga = nil
			begin
				utilizacoes  = doc.css('table.consulta')[2].css('tr.rowTable td').map{|c| VisaVale::Utilizacao.new(c) }
				ult_recarga  = doc.css('table.consulta')[0].css('tr.rowTable')[2].css('td')[1].content
				ult_recarga  = Date.strptime(ult_recarga.concat("/#{Time.now.year.to_s}"),"%d/%m/%Y") if ult_recarga
				ult_recarga  = ult_recarga - 1.year if ult_recarga && ult_recarga > Time.now.to_date
				prox_recarga = doc.css('table.consulta')[0].css('tr.rowTable')[3].css('td')[1].content
				prox_recarga = Date.strptime(prox_recarga.concat("/#{Time.now.year.to_s}"),"%d/%m/%Y") if !prox_recarga.blank?
				@quantia     = doc.css('td.corUm.fontWeightDois').last.content.split[1].gsub(",",".").to_f
			# rescue NoMethodError
			# 	raise ArgumentError, "Cartão inválido!"
			end

			@data_input = params[:data_entrada].present?
			@entrada   = prox_recarga unless prox_recarga.blank?
			@entrada ||= Date.strptime(params[:data_entrada], "%d/%m/%Y") rescue nil
			@entrada ||= ult_recarga + 1.month

			# Se a última utilização foi hoje, ignorar o dia atual
			@ja_almocou = utilizacoes.last.data == Date.today
			ignorar = 0
			ignorar = 1 if @ja_almocou
			ignorar += params[:numero_feriados].to_i

			dias_uteis = ((Time.now.to_date..@entrada-1.day).collect(&:wday) - [6, 0]).count - ignorar
			@valor = @quantia.to_f / dias_uteis
		end
	end
end
