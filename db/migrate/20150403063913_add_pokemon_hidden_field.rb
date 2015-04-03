class AddPokemonHiddenField < ActiveRecord::Migration
  def change
  	add_column :pokemons, :hidden, :boolean
  end
end
