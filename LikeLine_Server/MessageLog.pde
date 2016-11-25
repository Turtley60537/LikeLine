class MessageLog {
  String sentence;
  PImage stump;
  String url;
  int person;  //0ならmyself、1ならopponent
  int x, y, w, h;

  MessageLog(String _sentence, int _person) {
    sentence = _sentence;
    person = _person;
    initSentence();
  }

  MessageLog(PImage _stump, String _url, int _person) {
    stump = _stump;
    url = _url;
    person = _person;
    initStump();
  }

  void initSentence() {
    if (person == 0) {
      x = (width-20) - int( textWidth(sentence)/2 );
    } else if (person == 1) {
      x = 20 + int( textWidth(sentence)/2 );
    } else {
      println("error");
    }

    w = int( textWidth(sentence) ) + 20;
    h = 40;
  }

  void initStump() {
    if (person == 0 /*== myself*/) {
      x = width-100;
    } else if (person == 1 /*==opponent*/) {
      x = 100;
    } else {
      println("error");
    }

    w = 50;
    h = 50;
  }

  void display(int _remarkedY) {
    rectMode(CENTER);
    imageMode(CENTER);
    y = _remarkedY;

    if (sentence != null) {
      fill(255);
      rect(x, y, w, h);
      fill(0);
      textAlign(CENTER, CENTER);
      text(sentence, x, y);
    } else if (stump != null) {
      image(stump, x, y, w, h);
    }

    rectMode(CORNER);
    textAlign(CORNER, CORNER);
    imageMode(CORNER);
  }
}