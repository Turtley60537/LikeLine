class Sync {
  void importMessage() {
    Client thisClient = myServer.available();
    if (thisClient != null) {
      String sharedSentence = thisClient.readString();
      int getTitleNumber = sharedSentence.indexOf("getTitle");
      int getURLNumber   = sharedSentence.indexOf("URL:");

      if (getTitleNumber != -1) {
        title += sharedSentence.replaceAll("getTitle", "");
        myServer.write("getTitleKameServer");
      } else if (getURLNumber != -1) {
        //importStump
        String URL = sharedSentence.replaceAll("URL:", "");

        int indexURL;
        int useIndex = -1;
        boolean addStumpFlag = true;
        for (int i=0; i<stumpList.size(); i++) {
          indexURL = stumpList.get(i).loadURL.indexOf(URL);
          if (indexURL != -1) {
            addStumpFlag = false;
            useIndex = i;
            break;
          }
        }
        if (addStumpFlag) {
          println(URL);
          stumpList.add(new Stumps(URL));
          useIndex = stumpList.size()-1;
        }

        //int newId = stumpList.size() -1;
        messageLog.add(new MessageLog(stumpList.get(useIndex).stumpImage, URL, 1 /*== opponent*/));

        String [] saveURL = new String [stumpList.size()];
        for (int i=0; i<stumpList.size(); i++) {
          saveURL[i] = stumpList.get(i).loadURL;
        }
        saveStrings("stumpSource.txt", saveURL);
      } else {
        //importSentence
        messageLog.add(new MessageLog(sharedSentence, 1 /*== opponent*/));
      }
      String [] saveLog = new String [messageLog.size()];
      for (int i=0; i<messageLog.size(); i++) {
        if (messageLog.get(i).sentence != null) {
          saveLog[i] = messageLog.get(i).sentence +","+ messageLog.get(i).person;
        } else if (messageLog.get(i).url != null) {
          saveLog[i] = "URL:"+messageLog.get(i).url +","+messageLog.get(i).person;
        }
      }
      saveStrings("likeLineLog.txt", saveLog);
    }
  }


  void exportSentence(int _shareId) {
    String sharingSentence = messageLog.get(_shareId).sentence;
    myServer.write( sharingSentence );
  }

  void exportStumpURL(int _shareId) {
    String sharingStump = stumpList.get(_shareId).loadURL;
    myServer.write( "URL:"+ sharingStump );
  }
}