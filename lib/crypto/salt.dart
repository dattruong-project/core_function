import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

class Salt {
  static List<int> generate(int length) {
    final Uint8List buffer = Uint8List(length);
    final Random rng = Random.secure();
    for (int i = 0; i < length; i++) {
      buffer[i] = rng.nextInt(256);
    }
    return buffer;
  }

  static String generateAsBase64String(int length) {
    const Base64Encoder encoder = Base64Encoder();
    return encoder.convert(generate(length));
  }
}