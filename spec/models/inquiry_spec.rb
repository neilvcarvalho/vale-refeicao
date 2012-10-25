require 'spec_helper'

describe Inquiry do

	let(:inquiry) { Inquiry.new(numero_vr: '4043000000000000') }
	before(:each) do
		FakeWeb.register_uri(:get, 'http://www.cartoesbeneficio.com.br/inst/convivencia/SaldoExtrato.jsp?numeroCartao=4043000000000000&periodoSelecionado=4&origem=', body: File.open(Rails.root + 'spec/fixtures/consulta.html').read)
	end

	describe '#initialize' do
		it 'generates an array of card use objects' do
			inquiry.card_uses.size.should == 87
		end
	end

	describe '#used_today?' do
		it 'returns true if the last card use was today' do
			inquiry.card_uses.first.stub(:date).and_return(Date.today)
			inquiry.used_today?.should be_true
		end
		it 'returns false if the last card use was not today' do
			inquiry.card_uses.first.stub(:date).and_return(Date.yesterday)
			inquiry.used_today?.should be_false
		end
	end

	describe '#last_recharge' do
		it 'returns the last recharge date' do
			inquiry.last_recharge.should == Date.civil(2012, 9, 28)
		end
	end

	describe '#next_recharge' do
		it 'returns the date when the card will be recharged' do
			inquiry.next_recharge.should == Date.civil(2012, 10, 26)
		end
	end

	describe '#possible_recharge' do
		it 'returns the next recharge date if informed' do
			inquiry.possible_recharge.should == Date.civil(2012, 10, 26)
		end
		it 'returns the the last recharge date + 1 month if not informed' do
			inquiry.stub(:next_recharge).and_return('')
			inquiry.possible_recharge.should == Date.civil(2012, 10, 28)
		end
	end

	describe '#possible_average' do
		it 'returns how much the card owner can spend each business day'
	end

	describe '#average_daily_spending' do
		it 'returns how much the card owner has been spending the last 90 uses'
	end

	describe '#time' do
		it 'returns the time the inquiry has been done' do
			inquiry.time.should == DateTime.strptime('25/10/2012 - 11:11:26', '%d/%m/%Y - %H:%M:%S')
		end
	end
end
