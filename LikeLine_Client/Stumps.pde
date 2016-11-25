class Stumps{
  PImage stumpImage;
  String loadURL;
  Stumps(String _loadURL){
    loadURL = _loadURL;
    stumpImage = loadImage(loadURL);
  }
}