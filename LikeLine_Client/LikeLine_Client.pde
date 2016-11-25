import processing.net.*;
import javax.swing.*;
import java.awt.*;
import java.applet.Applet;

Client myClient = new Client(this, "127.0.0.1", 12345);

InputMessage inputMessage;  //テキスト入力画面
InputMessage inputNewStumpURL;
ArrayList<MessageLog> messageLog;
ArrayList<Stumps>  stumpList;
Parts     parts;
Sync      sync;
MethodBox method;

String title;

int firstMessage_y;

int stumpButton_x, 
  stumpButton_y, 
  stumpButton_r, 
  addStumpButton_x, 
  addStumpButton_y, 
  addStumpButton_r;
String newStumpURL;

int stumpBox_x, 
  stumpBox_y, 
  stumpBox_w, 
  stumpBox_h;

boolean stumpListVisible;
int firstStump_x;

boolean scrollStumpFlag;
int distX, preMouseX;

int editField_x, 
  editField_y, 
  editField_w, 
  editField_h;

int remarkButton_x, 
  remarkButton_y, 
  remarkButton_w, 
  remarkButton_h;

String  preRemarkMessage = "";
boolean remarkButtonColor;

PFont myFont;

boolean scrollLogFlag;
int distY;

void setup() {
  size(600, 700);
  myFont = createFont("FontCourier-Bold-48.vlw", 20);
  textFont(myFont);
  inputMessage     = new InputMessage("Write Your Message", "InputMessage");
  inputNewStumpURL = new InputMessage("Write New Stump URL", "InputURL");
  messageLog       = new ArrayList<MessageLog>();
  stumpList        = new ArrayList<Stumps>();
  parts            = new Parts();
  sync             = new Sync();
  method           = new MethodBox();

  String [] loadStumpURL = loadStrings("./stumpSource.txt");
  for (int i=0; i<loadStumpURL.length; i++) {
    stumpList.add(new Stumps(loadStumpURL[i]));
  }

  String [] loadLog = loadStrings("./likeLineLog.txt");
  //likeLineLog.txtには "URL:~~~~,opponent" のような形式で保存
  if (loadLog!=null) {
    for (int i=0; i<loadLog.length; i++) {
      String [] data = split(loadLog[i], ",");
      int getURLNumber = data[0].indexOf("URL:");
      println(data[0], data[1]);
      if (getURLNumber != -1) {
        String URL = data[0].replaceAll("URL:", "");
        //stumpList.add(new Stumps(URL));
        
        int indexURL;
        int useIndex = -1;
        for (int j=0; j<stumpList.size(); j++) {
          indexURL = stumpList.get(j).loadURL.indexOf(URL);
          if(indexURL != -1) {
            useIndex = j;
            break;
          }
        }
        messageLog.add(new MessageLog(stumpList.get(useIndex).stumpImage, URL, int(data[1])));
        println(data[1]);
      } else {
        String sentence = data[0];
        println(textWidth(sentence));
        messageLog.add(new MessageLog(sentence, int(data[1])));
      }
    }
  }

  title = "Opponent: ";
  myClient.write("getTitleKameClient");

  firstMessage_y = 100;
  firstStump_x   = 20;

  stumpButton_x = 25;
  stumpButton_y = height-25;
  stumpButton_r = 35;

  stumpBox_x = 0;
  stumpBox_y = height-150;
  stumpBox_w = width;
  stumpBox_h = 100;

  editField_x = 50;
  editField_y = height-40;
  editField_w = width-130;
  editField_h = 30;

  remarkButton_x = width-70;
  remarkButton_y = height-40;
  remarkButton_w = 60;
  remarkButton_h = 30;
}

void stop() {
  myClient.stop();
}

void draw() {
  sync.importMessage();

  background(#AFE7F7);
  noStroke();

  if (scrollLogFlag) {
    firstMessage_y = mouseY + distY;
    if (firstMessage_y >= 100) {
      firstMessage_y = 100;
    }
  }

  for (int i=0; i<messageLog.size(); i++) {
    int sentY = firstMessage_y + 50*i;
    messageLog.get(i).display(sentY);
  }

  parts.top();
  parts.bottom();
  parts.stumpButton();
  parts.editField();
  parts.remarkButton();
}

void mousePressed() {
  if (method.mouseInStumpButton()) {
    stumpListVisible = stumpListVisible ? false : true;
    return;
  }

  if (method.mouseInEditField()) {
    preRemarkMessage = inputMessage.input();
    return;
  }

  if (method.mouseInRemarkButton()) {
    if (preRemarkMessage != "") method.remarkSentence();
    return;
  }

  if (!stumpListVisible) {
    if (method.mouseInCenter() && messageLog.size()>=12) {
      scrollLogFlag = true;
      distY         = firstMessage_y - mouseY;
      return;
    }
  }

  if (stumpListVisible) {
    if (method.mouseInCenter() && !method.mouseInStumpBox()) {
      stumpListVisible = false;
      if (messageLog.size()>=12) {
        distY = firstMessage_y - mouseY;
      }
      return;
    } else if (method.mouseInStumpBox()) {
      scrollStumpFlag = true;
      distX           = firstStump_x - mouseX;
      preMouseX       = mouseX;
      return;
    }
  }
}

void mouseReleased() {
  if (stumpListVisible && abs(mouseX - preMouseX)<=5) method.remarkStump();
  if (stumpListVisible && method.mouseInAddStump()) {
    newStumpURL = inputNewStumpURL.input();
    stumpList.add(new Stumps(newStumpURL));

    String [] saveURL = new String [stumpList.size()];
    for (int i=0; i<stumpList.size(); i++) {
      saveURL[i] = stumpList.get(i).loadURL;
    }
    saveStrings("stumpSource.txt", saveURL);
  }
  if (remarkButtonColor) remarkButtonColor = false;
  if (scrollLogFlag)     scrollLogFlag     = false;
  if (scrollStumpFlag)   scrollStumpFlag   = false;
}

void keyPressed() {
  switch (keyCode) {
  case ENTER:
    if (preRemarkMessage != "") method.remarkSentence();
  }
}

void keyReleased() {
  switch(keyCode) {
  case ENTER:
    remarkButtonColor = false;
  }
}