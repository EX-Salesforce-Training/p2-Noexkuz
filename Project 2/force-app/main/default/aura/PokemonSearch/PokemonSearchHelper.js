({
  showToast : function(component, event, helper) {
    var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
        "message": "Your Pokemon has been saved!",
        "type": "success"
    });
    toastEvent.fire();
  }
})