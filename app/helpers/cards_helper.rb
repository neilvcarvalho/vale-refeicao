module CardsHelper
	def grafico_gastos_diarios(card)
		content_tag(:div, '', id: 'gastos_diarios', data: { gastos: agrupamento_diario_grafico(card) })
	end

	def agrupamento_diario_grafico(card)
		# card.inquiry.card_uses[1..30].reverse.map{|use| {date: use.date, value: use.value, average: 17}}
		uses = card.inquiry.card_uses
		(card.inquiry.last_recharge..Date.today).map do |date|
			{
				date: date.strftime('%d/%m'),
				value: uses.find_all{ |use| use.date == date }.map(&:value).sum.to_f.round(2),
				average: card.inquiry.possible_average
			}
		end
	end
end
