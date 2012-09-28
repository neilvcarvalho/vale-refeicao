class CardsController < InheritedResources::Base

	def create
		create! { cards_path }
	end

	def update
		update! { cards_path }
	end

	def show
		show!
	end

	protected
	def collection
		@cards ||= current_user.cards
	end

	protected
	def begin_of_association_chain
		current_user
	end
end
