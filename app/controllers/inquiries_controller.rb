require 'visavale/utilizacao'
require 'visavale/busca'

class InquiriesController < ApplicationController

	def create
		if params[:numero_vr]
			begin
				busca = VisaVale::Busca.new(params)
				@valor      = busca.valor
				@quantia    = busca.quantia
				@ja_almocou = busca.ja_almocou
				@data_input = busca.data_input
				@entrada    = busca.entrada
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
