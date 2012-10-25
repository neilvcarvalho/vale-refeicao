class InquiriesController < ApplicationController

	def create
		if params[:numero_vr]
			begin
				inquiry = Inquiry.new(params)
				@valor      = inquiry.valor
				@quantia    = inquiry.quantia
				@ja_almocou = inquiry.ja_almocou
				@data_input = inquiry.data_input
				@entrada    = inquiry.entrada
			rescue ArgumentError => error
				@erro = error.message
			end

			cookies["numero_cartao"] = params[:numero_vr]

			respond_to do |format|
				format.js
			end
		end
	end
end
