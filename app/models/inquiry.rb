# encoding: utf-8
require "nokogiri"
require 'net/http'
require 'uri'

class Inquiry
	attr_accessor :valor, :quantia, :data_input, :entrada, :ja_almocou, :html
	def initialize(params)
		numero_vr = params[:numero_vr]

		# FakeWeb.register_uri(:get, 'http://www.cartoesbeneficio.com.br/inst/convivencia/SaldoExtrato.jsp?numeroCartao=4043470371420015&periodoSelecionado=4&origem=', body: File.open(Rails.root + 'spec/fixtures/consulta.html').read)
		data = Rails.cache.fetch("cache_#{numero_vr}", expires_in: 6.hours) { Net::HTTP.get(URI.parse("http://www.cartoesbeneficio.com.br/inst/convivencia/SaldoExtrato.jsp?numeroCartao=#{numero_vr}&periodoSelecionado=4&origem=")) }
		@html = Nokogiri::HTML(data)

		@data_input = params[:data_entrada].present?
		@entrada = possible_recharge
	end

	def card_uses
		@card_uses ||= html.css('table.consulta')[2].css('tr.rowTable').map{|c| CardUse.new(c) }.delete_if{|use| use.place == 'Disponibilização de Benefício'}
	end

	def used_today?
		@used_today ||= card_uses.first.date == Date.today
	end

	def last_recharge
		text = html.css('table.consulta')[0].css('tr.rowTable')[2].css('td')[1].content
		last_recharge = Date.strptime(text.concat("/#{Time.now.year.to_s}"),"%d/%m/%Y") if text
		last_recharge = last_recharge - 1.year if last_recharge && last_recharge > Time.now.to_date
		last_recharge
	end

	def next_recharge
		next_recharge = html.css('table.consulta')[0].css('tr.rowTable')[3].css('td')[1].content
		next_recharge = Date.strptime(next_recharge.concat("/#{Time.now.year.to_s}"),"%d/%m/%Y") if !next_recharge.blank?
		next_recharge
	end

	def possible_recharge
		entrada   = next_recharge unless next_recharge.blank?
		entrada ||= Date.strptime(params[:data_entrada], "%d/%m/%Y") rescue nil
		entrada ||= last_recharge + 1.month
		entrada
	end

	def possible_average
		ignore = used_today? && possible_recharge > Date.tomorrow ? 1 : 0

		business_days = ((Time.now.to_date..possible_recharge-1.day).collect(&:wday) - [6, 0]).count - ignore
		balance.to_f / business_days
	end

	def balance
		html.css('td.corUm.fontWeightDois').last.content.split[1].gsub(",",".").to_f
	end

	def time
		DateTime.strptime(html.css('table.consulta')[0].css('tr.rowTable')[0].css('td')[1].content, '%d/%m/%Y - %H:%M:%S')
	end
end
