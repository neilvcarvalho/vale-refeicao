# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	if $('#gastos_diarios').length > 0
		Morris.Line
			element: 'gastos_diarios'
			data: $('#gastos_diarios').data('gastos')
			xkey: 'date'
			ykeys: ['value', 'average']
			labels: ['Quanto gastou', 'Quanto pode gastar'],
			parseTime: false,
			preUnits: 'R$ '