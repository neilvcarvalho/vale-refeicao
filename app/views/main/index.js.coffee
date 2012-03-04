jQuery ->
	$("#resultado").show()
	$("#quanto_pode").html("Você pode gastar <span class='valor'><%=number_to_currency @valor%></span> por dia")
	$("#saldo").html("Seu saldo é <span class='valor'><%= number_to_currency @quantia %></span>")
	$("#data").text("") if <%= @data_input %>
	$("#data").text("(a data estimada da próxima entrada é <%=@entrada.strftime('%d/%m/%Y')%>)") unless <%= @data_input %>
	$("#almoco").text('Você já almoçou hoje :)') if <%= @ja_almocou %>
	$('#almoco').text('Você ainda não almoçou hoje :(') unless <%= @ja_almocou %>