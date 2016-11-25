class Parts {
  void top() {
    rectMode(CORNER);
    fill(200);
    rect(0, 0, width, 50);
    fill(0);
    textAlign(CENTER, CENTER);
    text(title, width/2, 25);
  }

  void bottom() {
    rectMode(CORNER);
    fill(200);
    rect(0, height-50, width, 50);
  }

  void stumpButton() {
    fill(#FFEB0D);
    ellipse(stumpButton_x, 
      stumpButton_y, 
      stumpButton_r, 
      stumpButton_r
      );
    if (stumpListVisible) {
      if (scrollStumpFlag) {
        firstStump_x = mouseX + distX;
        if (firstStump_x >= 20) {
          firstStump_x = 20;
        }
      }

      fill(100);
      rect(stumpBox_x, 
        stumpBox_y, 
        stumpBox_w, 
        stumpBox_h
        );
      for (int i=0; i<stumpList.size(); i++) {
        int stump_x = firstStump_x + 100*i;
        int stump_y = height - 150;
        image(stumpList.get(i).stumpImage, stump_x, stump_y, 100, 100);
      }
      addStumpButton_x = 30 + firstStump_x + 100*stumpList.size();
      addStumpButton_y = 50 + height - 150;
      addStumpButton_r = 30;
      fill(#06C61E);
      ellipse(addStumpButton_x, 
        addStumpButton_y, 
        addStumpButton_r, 
        addStumpButton_r
        );
      stroke(-1);
      strokeWeight(3);
      line(addStumpButton_x-7, 
        addStumpButton_y, 
        addStumpButton_x+7, 
        addStumpButton_y
        );
      line(addStumpButton_x, 
        addStumpButton_y-7, 
        addStumpButton_x, 
        addStumpButton_y+7
        );
      noStroke();
      strokeWeight(1);
    }
  }

  void editField() {
    fill(-1);
    rect(editField_x, editField_y, editField_w, editField_h);
    fill(0);
    textAlign(LEFT, CENTER);
    if (preRemarkMessage != null) {
      text(preRemarkMessage, 
        editField_x + 10, 
        editField_y + (editField_h / 2)
        );
    }
  }

  void remarkButton() {
    if (remarkButtonColor) fill(#FFB324);
    else fill(#00C5FF);
    rect(remarkButton_x, 
      remarkButton_y, 
      remarkButton_w, 
      remarkButton_h
      );

    textAlign(CENTER, CENTER);
    fill(-1);

    text("送信", width-40, height-27);
  }
}