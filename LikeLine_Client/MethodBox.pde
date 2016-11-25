class MethodBox {
  void remarkSentence() {
    if (preRemarkMessage!=null) {
      remarkButtonColor = true;
      messageLog.add(new MessageLog(preRemarkMessage, 0 /*== myself*/));
      preRemarkMessage = "";
      int shareId = messageLog.size()-1;

      //exportMessage
      sync.exportSentence(shareId);

      String [] saveLog = new String [messageLog.size()];
      for (int i=0; i<messageLog.size(); i++) {
        if (messageLog.get(i).sentence != null) {
          saveLog[i] = messageLog.get(i).sentence + "," + messageLog.get(i).person;
        } else if (messageLog.get(i).url != null) {
          saveLog[i] = "URL:" + messageLog.get(i).url + "," + messageLog.get(i).person;
        }
      }
      saveStrings("likeLineLog.txt", saveLog);
    }
  }

  void remarkStump() {
    for (int i=0; i<stumpList.size(); i++) {
      int stump_x = firstStump_x + 100*i;
      int stump_y = height - 150;

      if (mouseInStumpImage(stump_x, stump_y)) {

        messageLog.add(new MessageLog(stumpList.get(i).stumpImage, stumpList.get(i).loadURL, 0 /*== myself*/));

        //exportStumpURL
        sync.exportStumpURL(i);

        //saveLog
        String [] saveLog = new String [messageLog.size()];
        for (int j=0; j<messageLog.size(); j++) {
          if (messageLog.get(j).sentence != null) {
            saveLog[j] = messageLog.get(j).sentence + "," + messageLog.get(j).person;
          } else if (messageLog.get(j).url != null) {
            saveLog[j] = "URL:" + messageLog.get(j).url + "," + messageLog.get(j).person;
          }
        }
        saveStrings("likeLineLog.txt", saveLog);
      }
    }
  }

  boolean mouseInStumpBox() {
    return mouseX >= stumpBox_x
      &&   mouseX <= stumpBox_x + stumpBox_w
      &&   mouseY >= stumpBox_y
      &&   mouseY <= stumpBox_y + stumpBox_h;
  }

  boolean mouseInStumpImage(int stumpX, int stumpY) {
    return mouseX >= stumpX
      &&   mouseX <= stumpX+100
      &&   mouseY >= stumpY
      &&   mouseY <= stumpY+100;
  }

  boolean mouseInStumpButton() {
    float temp = dist(mouseX, mouseY, stumpButton_x, stumpButton_y);
    return temp <= (stumpButton_r / 2);
  }
  
  boolean mouseInAddStump(){
    float temp = dist(mouseX, mouseY, addStumpButton_x, addStumpButton_y);
    return temp <= (addStumpButton_r / 2);
  }

  boolean mouseInEditField() {
    return mouseX >= editField_x
      &&   mouseX <= editField_x + editField_w
      &&   mouseY >= editField_y
      &&   mouseY <= editField_y + editField_h;
  }

  boolean mouseInRemarkButton() {
    return mouseX >= remarkButton_x
      &&   mouseX <= remarkButton_x + remarkButton_w
      &&   mouseY >= remarkButton_y
      &&   mouseY <= remarkButton_y + remarkButton_h;
  }

  boolean mouseInCenter() {
    return mouseX >= 0
      && mouseX <= width
      && mouseY >= 50
      && mouseY <= height-50;
  }
}