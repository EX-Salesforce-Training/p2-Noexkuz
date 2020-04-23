({
    handleClick : function (component, event, helper) {
      var pokemonName = component.get("v.pokemonName");
      var action = component.get("c.getPokemon");
      action.setParams({"pokemonName" : pokemonName});
      action.setCallback(this, function(response) {
        var state = response.getState();
        if (state === "SUCCESS") {
          var url = "https://pokeres.bastionbot.org/images/pokemon/"
          component.set("v.name",response.getReturnValue().name);
          component.set("v.weight",response.getReturnValue().weight);
          component.set("v.height",response.getReturnValue().height);
          component.set("v.base_experience",response.getReturnValue().base_experience);
          component.set("v.pokemonId",response.getReturnValue().pokemonId);
          component.set("v.abilities",response.getReturnValue().abilities);
          var img = url + response.getReturnValue().pokemonId + ".png";
          component.set("v.imgurl",img);
        } else {
          console.log(state);
        }
      });
      $A.enqueueAction(action);
  },

  handleSave : function (component, event, helper) {
    var pokemon = component.get("v.pokemon");
    var name = component.get("v.name");
    var weight = component.get("v.weight");
    var height = component.get("v.height");
    var base_experience = component.get("v.base_experience");
    var pokemonId = component.get("v.pokemonId");
    var abilities = component.get("v.abilities");
    var action = component.get("c.savePokemon");
    action.setParams({"name" : name, "weight" : weight, "height" : height, "base_experience" : base_experience, "pokemonId" : pokemonId, "abilities" : abilities});
    action.setCallback(this, function(response){
      var state = response.getState();
      if (state === "SUCCESS") {
        pokemon = response.getReturnValue();
      } else {
        console.log(state);
      }
    });
    $A.enqueueAction(action);
  }
})
