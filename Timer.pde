// Class for timer 
// Timer is used to stagger release of eggs, bad eggs, golden eggs and text display

class Timer {
  // Properties
  int startTime;
  int interval;

  // Constructor
  Timer(int timeInterval) {
    interval = timeInterval;
  }//timer

  // Methods
  void start() {
    startTime = millis();
  }//start

  boolean complete() {
    int elapsedTime = millis() - startTime;
    if (elapsedTime > interval) {
      return true;
    } else {
      return false;
    }
  }//complete
}//end of class body
