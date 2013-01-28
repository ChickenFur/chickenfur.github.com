//Will Create The boxes to be displayed
var makeBoxManager = function(){
  boxManager = {
    makeBoxes: function (arrayOfBoxData){
      var arrayOfJQueryObjects = [];
      var svg = d3.select("#d3canvas")
        .append("svg")
        .attr("width", "100%")
        .attr("height", "200");

      var toTheRight = 40;  
      arrayOfBoxData.forEach(function (i){
        debugger;
        var aBox = svg.append("rect")
          .attr("x", (60 + toTheRight * i))
          .attr("y", 60)
          .attr("width", 60)
          .attr("height", 60);
      });
      return appendToPage;
    },
    arrayOfJQueryObjects: function (){
    },
    animateBoxes: function(direction){
    }
  };
  return boxManager;
};