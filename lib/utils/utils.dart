import 'dart:math';
import 'dart:ui';

class Utils{
  
  static Color getRandomColor() {
    Random random = Random();
    return Color.fromRGBO(
      random.nextInt(128),
      random.nextInt(128),
      random.nextInt(128),
      1,
    );
  }
  
}