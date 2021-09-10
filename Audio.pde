class Audio{
  Button btnchoose, btnplay, btnpause, btnstop;
  String getFile = null;
  String playingtitle = "", choosetitle;
  int pause = 0; //0が初期、再生中が1、一時停止が2
  AudioPlayer player;
  
  void makeButton(int x){
    btnchoose = new Button(x, 0, loadImage("choose.png"));
    btnplay = new Button(x, btnchoose.sizeY, loadImage("play.png"));
    btnpause = new Button(x, btnchoose.sizeY, loadImage("pause.png"));
    btnstop = new Button(x, btnpause.y+btnpause.sizeY, loadImage("stop.png"));
  }
  
  void writeFileName(int x, int y){
    if(getFile!=null){
      //選択されているファイルを表示
      fill(255,255,255);
      choosetitle = getFile.substring(getFile.lastIndexOf('/') + 1);
      text("choosing: " + choosetitle, x, y);
      text("playing: " + playingtitle, x, y+btnchoose.sizeY);
    }
  }
  
  void setButton(){
    btnchoose.run();
    if(pause!=1) btnplay.run();
    else btnpause.run();
    btnstop.run();
  }
  
  void buttonPressed(){
    //chooseボタンが押されたら曲を選ぶ
    if(btnchoose.isPush()) getFile = getFileName();  
    //playボタンが押されたら再生
    if(btnplay.isPush()){
      if(getFile!=null && pause !=1) {
        fileLoader();
        playingtitle = choosetitle;
        pause = 1;
      }
      else if(player!=null){
        player.pause();
        playingtitle = choosetitle;
        pause = 2;
      }
    }
    //pauseボタンが押されたら一時停止
    /*if(btnpause.isPush()) {
      if(player!=null && pause == 1) {
        player.pause();
        playingtitle = choosetitle;
        pause = 2;
      }
    }*/  
    //stopボタンが押されたら停止
    if(btnstop.isPush()) {
      if(player!=null) {
        player.close();
        pause = 0;
        player = null;
        playingtitle = "";
      }
    }
  }
  
  
  void fileLoader(){
    //選択ファイルパスのドット以降の文字列を取得
    String ext = getFile.substring(getFile.lastIndexOf('.') + 1);
    //その文字列を小文字にする
    ext.toLowerCase();
    //文字列末尾がmp3であれば 
    if(ext.equals("mp3")){
      //既に再生しているものがあれば
      if(player!=null) {
        //一時停止を再開ならそのまま再生
        if(playingtitle.equals(choosetitle)) player.loop();
        //別の曲に変更するなら最初から流す
        else {
          player.close();
          player = minim.loadFile(getFile);
          fft = new FFT(player.bufferSize(), player.sampleRate());
          player.loop();
        }
      }
      //選択ファイルパスのファイルを取り込む
      else {
        player = minim.loadFile(getFile);
        fft = new FFT(player.bufferSize(), player.sampleRate());
        //再生
        player.loop();
      }
    }
    //選択ファイルパスを空に戻す
    //getFile = null; 
  }
  
  
  String getFileName(){
    //処理タイミングの設定 
    SwingUtilities.invokeLater(new Runnable() { 
      public void run() {
        try {
          //ファイル選択画面表示 
          JFileChooser fc = new JFileChooser(); 
          int returnVal = fc.showOpenDialog(null);
          //「開く」ボタンが押された場合
          if (returnVal == JFileChooser.APPROVE_OPTION) {
            //選択ファイル取得   
            File file = fc.getSelectedFile();
            //選択ファイルのパス取得 
            getFile = file.getPath(); 
          }
        }
        //上記以外の場合 
        catch (Exception e) {
          //エラー出力 
          e.printStackTrace(); 
        } 
      }
    }
    );
    //選択ファイルパス取得
    return getFile; 
  }

  
  
  
}
