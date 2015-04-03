class PokemonsController < ApplicationController

    attr_reader :hidden

    def capture
        @p = Pokemon.find(params[:id])
        @p.trainer_id = current_trainer.id
        @p.save!

        redirect_to "/"
    end

    def damage
        @p = Pokemon.find(params[:id])
        @p.health -= 10

        if @p.health <= 0 
            # Pokemon.destroy(params[:id])
            @p.health = 0
            @p.hidden = true
        end
        @p.save!

        redirect_to "/trainers/" + @p.trainer_id.to_s
    end

    def heal
        @p = Pokemon.find(params[:id])
        @p.health += 10

        if @p.health > 0
            @p.hidden = false
        end
        if @p.health > 100
            @p.health = 100
        end
        @p.save!

        redirect_to "/trainers/" + @p.trainer_id.to_s
    end

    def new
        @pokemon = Pokemon.new
    end

    def create
        @pokemon = Pokemon.create(pokemon_params)
        @pokemon.health = 100
        @pokemon.level = 1
        @pokemon.trainer_id = current_trainer.id
        if @pokemon.save
            redirect_to "/trainers/" + @pokemon.trainer_id.to_s
        else
            flash.now[:error] = @pokemon.errors.full_messages.to_sentence
            render "new"
        end
    end

    private

    def pokemon_params
        params.require(:pokemon).permit(:name)
    end

end