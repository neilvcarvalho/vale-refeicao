require 'nokogiri'
require 'open-uri'

class MainController < ApplicationController
	def index
		if params[:numero_vr]
			@numero_vr = params[:numero_vr]
			session["numero_cartao"] = @numero_vr

			doc = Nokogiri::HTML(open("http://www.cbss.com.br/inst/convivencia/SaldoExtrato.jsp?numeroCartao=#{@numero_vr}"))

			logger.debug "###########################"
			logger.debug doc.content

			@ult_utilizacao = doc.css('table.consulta')[2].css('tr.rowTable td').first.content
			@ult_recarga    = doc.css('table.consulta')[0].css('tr.rowTable')[2].css('td')[1].content
			@ult_recarga    = Date.strptime(@ult_recarga.concat("/#{Time.now.year.to_s}"),"%d/%m/%Y") if @ult_recarga
			@ult_recarga    = @ult_recarga - 1.year if @ult_recarga && @ult_recarga > Time.now.to_date
			@prox_recarga   = doc.css('table.consulta')[0].css('tr.rowTable')[3].css('td')[1].content
			@prox_recarga   = Date.strptime(@prox_recarga.concat("/#{Time.now.year.to_s}"),"%d/%m/%Y") if !@prox_recarga.blank?
			@quantia        = doc.css('td.corUm.fontWeightDois').last.content.split[1].gsub(",",".").to_f

			@entrada   = @prox_recarga unless @prox_recarga.blank?
			@entrada ||= Date.new(params[:data_entrada][:"(1i)"].to_i, params[:data_entrada][:"(2i)"].to_i, params[:data_entrada][:"(3i)"].to_i) rescue nil
			@entrada ||= @ult_recarga + 1.month

			# Se a última utilização foi hoje, ignorar o dia atual
			@ja_almocou = @ult_utilizacao == Time.now.strftime("%d/%m")
			ignorar = 0
			ignorar = 1 if @ja_almocou
			ignorar += params[:numero_feriados].to_i

			@dias_uteis = ((Time.now.to_date..@entrada-1.day).collect(&:wday) - [6, 0]).count - ignorar
			@valor = @quantia.to_f / @dias_uteis
			respond_to do |format|
				format.js
			end
		end
	end
end
