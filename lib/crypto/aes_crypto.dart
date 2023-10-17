
import 'package:encrypt/encrypt.dart';

class AESCrypto {

  static String decrypt(String keyString, Encrypted encryptedData) {
    final key = Key.fromUtf8(keyString);
    final encrypt = Encrypter(AES(key));
    final initVector = IV.fromLength(16);
    return encrypt.decrypt(encryptedData, iv: initVector);
  }

  static Encrypted encrypt(String keyString, String plainText) {
    final key = Key.fromUtf8(keyString);
    final encrypt = Encrypter(AES(key));
    final initVector = IV.fromLength(16);
    Encrypted encryptedData = encrypt.encrypt(plainText, iv: initVector);
    return encryptedData;
  }
}