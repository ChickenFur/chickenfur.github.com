//compiles the box data
var makeBoxDataGetter = function(){
  boxDataGetter = {
    getData: function (){
      return [boxData, boxData1];
    }
  };
  return boxDataGetter;
};