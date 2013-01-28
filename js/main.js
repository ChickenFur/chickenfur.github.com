//This is where all our javascript is launched from
var boxManager = makeBoxManager();
boxDataGetter = makeBoxDataGetter();
boxManager.makeBoxes(boxDataGetter.getData());
boxManager.appendToPage();

