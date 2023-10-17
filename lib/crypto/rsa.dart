import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';

class RSACrypto {
  RSACrypto._();

  static final RSACrypto _instance = RSACrypto._();

  static RSACrypto get instance => _instance;

  late Encrypter _encrypter;

  init(
      {required RSAPublicKey publicKey, required RSAPrivateKey privateKey}){
    _encrypter = Encrypter(RSA(publicKey: publicKey, privateKey: privateKey));
    return _instance;
  }

  Encrypted encrypt(String plaintText) {
    return _encrypter.encrypt(plaintText);
  }

  String decrypt(Encrypted encrypted) {
    return _encrypter.decrypt(encrypted);
  }

}