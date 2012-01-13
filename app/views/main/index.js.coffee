jQuery ->
	$("#quanto_pode").html("Você pode gastar <%=number_to_currency @valor%> por dia")
	$("#quanto_pode").append("<br/>Seu saldo é <%= number_to_currency @quantia %>")
	$("#quanto_pode").append('<br/>Você já almoçou hoje :)') if <%= @ja_almocou %>
	$('#quanto_pode').append('<br/>Você ainda não almoçou hoje :(') unless <%= @ja_almocou %>