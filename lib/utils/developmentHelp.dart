import 'dart:math';

class developmentHelper {
  static final random = Random();
  static String randomPictureUrl() {
    final randInt = random.nextInt(1000);
    return 'http://picsum.photos/seed/$randInt/300/300';
  }
}
