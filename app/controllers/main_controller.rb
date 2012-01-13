class MainController < ApplicationController
	def index
		if params[:quanto_tem]
			@quantia  = params[:quanto_tem]
			@entrada  = Date.new(params[:data_entrada][:"(1i)"].to_i, params[:data_entrada][:"(2i)"].to_i, params[:data_entrada][:"(3i)"].to_i)
			@feriados = params[:numero_feriados]
			
			@dias_uteis = ((Time.now.to_date..@entrada-1.day).collect(&:wday) - [6, 0]).count - @feriados.to_i
			@valor = @quantia.to_f / @dias_uteis
			respond_to do |format|
				format.js
			end
		end
	end

end
