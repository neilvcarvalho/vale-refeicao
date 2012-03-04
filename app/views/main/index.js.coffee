jQuery ->
	$("#resultado").show()
	$("#quanto_pode").html("Você pode gastar <span class='valor'><%=number_to_currency @valor%></span> por dia")
	$("#saldo").html("Seu saldo é <span class='valor'><%= number_to_currency @quantia %></span>")
	$("#almoco").html('Você já almoçou hoje :)') if <%= @ja_almocou %>
	$('#almoco').html('Você ainda não almoçou hoje :(') unless <%= @ja_almocou %>