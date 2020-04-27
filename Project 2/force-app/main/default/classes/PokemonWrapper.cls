public with sharing class PokemonWrapper {
    
    @AuraEnabled public String name {get; set;}
    @AuraEnabled public Integer weight {get; set;}
    @AuraEnabled public Integer height {get; set;}
    @AuraEnabled public Integer base_experience {get; set;}
    @AuraEnabled public Integer pokemonId {get; set;}
    @AuraEnabled public List<String> abilities {get; set;}
}