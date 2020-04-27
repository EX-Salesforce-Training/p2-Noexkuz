public with sharing class PokemonSearchController {
    
    @AuraEnabled
    public static PokemonWrapper getPokemon(String pokemonName){
        
      PokemonWrapper pokemon = new PokemonWrapper();
      Http http = new Http();
      HttpRequest request = new HttpRequest();
      request.setEndpoint('https://pokeapi.co/api/v2/pokemon/'+pokemonName);
      request.setMethod('GET');
      
      HttpResponse response = http.send(request);

      
      if (response.getStatusCode() == 200) {
          // Deserializes the JSON string into collections of primitive data types.
          Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
          // Cast the values in the 'abilities' key as a list
          List<Object> abilities  = (List <Object>) results.get('abilities');
          List<String> abilityList = new List<String>();
          for(Object x: abilities){
              Map<String, Object> ability = (Map<String, Object>) x;
              String a1 = JSON.serialize(ability.get('ability'));
              Map<String, Object> a2= (Map<String, Object>) JSON.deserializeUntyped(a1);
              String abilityName = a2.get('name').toString();
            
              abilityList.add(abilityName);
          }
          
          pokemon.name = results.get('name').toString();
          pokemon.weight = (Integer) results.get('weight');
          pokemon.height = (Integer) results.get('height');
          pokemon.base_experience = (Integer) results.get('base_experience');
          pokemon.pokemonId = (Integer) results.get('id');
          pokemon.abilities = abilityList;
          
      }
      return pokemon;
  }

  @AuraEnabled
  public static Pokemon__c savePokemon(String name, Integer weight, Integer height, Integer base_experience, Integer pokemonId, String[] abilities){
    
    Pokemon__c pokemon = new Pokemon__c();
    pokemon.Name__c = name;
    pokemon.Weight__c = weight;
    pokemon.Height__c = height;
    pokemon.Base_Experience__c = base_experience;
    pokemon.Pokemon_Id__c = pokemonId;
      if(abilities.size() == 1){
        pokemon.Ability1__c = String.valueOf(abilities[0]);
        pokemon.Ability2__c = 'None';
        pokemon.Ability3__c = 'None'; 
      } else if(abilities.size() == 2){
        pokemon.Ability1__c = String.valueOf(abilities[0]);
        pokemon.Ability2__c = String.valueOf(abilities[1]);
        pokemon.Ability3__c = 'None';
      } else if(abilities.size() == 3){
        pokemon.Ability1__c = String.valueOf(abilities[0]);
        pokemon.Ability2__c = String.valueOf(abilities[1]);
        pokemon.Ability3__c = String.valueOf(abilities[2]);
      }
    insert pokemon;
    return pokemon;
  }
}