class CardsController < InheritedResources::Base

	# caches_action :show, layout: false

	def index
		index!
		fresh_when last_modified: @cards.maximum(:updated_at)
	end

	def create
		create! { cards_path }
	end

	def update
		update! { cards_path }
	end

	def show
		@card = Card.find(params[:id])
		expires_in 6.hours
		if params[:cache] == 'false'
			expires_now
			Rails.cache.delete("cache_#{@card.number}")
			expire_fragment("show_data_#{@card.number}")
		end
	end

	protected
	def collection
		@cards ||= current_user.cards
	end

	def begin_of_association_chain
		current_user
	end
end
