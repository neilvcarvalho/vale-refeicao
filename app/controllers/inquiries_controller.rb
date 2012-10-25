class InquiriesController < ApplicationController

	def create
		if params[:numero_vr]
			begin
				inquiry = Inquiry.new(params)
				@valor      = inquiry.possible_average
				@quantia    = inquiry.balance
				@ja_almocou = inquiry.used_today?
				@data_input = inquiry.data_input
				@entrada    = inquiry.possible_recharge
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
