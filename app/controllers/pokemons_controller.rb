class PokemonsController < ApplicationController

    def capture
        p = Pokemon.find(params[:id])
        p.trainer_id = current_trainer.id
        p.save!

        redirect_to "/"
    end

    def damage
        p = Pokemon.find(params[:id])
        trainer_id = p.trainer_id
        p.health -= 10

        if p.health <= 0 
            Pokemon.destroy(params[:id])
        end
        p.save!

        redirect_to "/trainers/" + trainer_id.to_s
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
            render "new"
        end
    end

    private

    def pokemon_params
        params.require(:pokemon).permit(:name)
    end

end