class InputMessage {
  //JPanelの要素
  JPanel     panel;
  BoxLayout  layout;
  JFrame     frame;
  JLabel     label;
  JTextField text1;

  String inputText;
  String labelText;
  String panelText;

  InputMessage(String _labelText, String _panelText) {
    panel  = new JPanel();
    label  = new JLabel("");
    text1  = new JTextField();
    layout = new BoxLayout(panel, BoxLayout.Y_AXIS);
    
    panel.add(label);
    panel.add(text1);
    
    labelText = _labelText;
    panelText = _panelText;
  }

  String input () {
    label.setText( labelText );
    text1.setText( preRemarkMessage );
    panel.setLayout( layout );
    int result = JOptionPane.showConfirmDialog(
      null, 
      panel, 
      panelText, 
      JOptionPane.OK_CANCEL_OPTION, 
      JOptionPane.QUESTION_MESSAGE
      );

    println(text1.getText());

    if (result==JOptionPane.OK_OPTION) {
      inputText = text1.getText();
    } else {
      inputText = preRemarkMessage;
    }
    return inputText;
  }
}