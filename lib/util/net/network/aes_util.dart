import 'package:encrypt/encrypt.dart';

/// 加解密工具类
class AesUtil {
  static const String _KEY = "76CAA1C88F7F8D1D";
  static const String _IV = "91129048100F0494";

  /// aes 加密
  static String encryptAESCbc128WithPadding7(String val) {
    try {
      final encrypter = Encrypter(AES(Key.fromUtf8(_KEY), mode: AESMode.cbc));
      final encrypted = encrypter.encrypt(val, iv: IV.fromUtf8(_IV));
      return encrypted.base64;
    } catch (err) {
      print("加密失败:$err");
      return val;
    }
  }

  /// aes 解密
  //AES解密
  static String aesDecrypt(String encrypted) {
    try {
      final key = Key.fromUtf8(_KEY);
      final iv = IV.fromUtf8(_IV);
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
      final decrypted = encrypter.decrypt16(encrypted, iv: iv);
      return decrypted;
    } catch (err) {
      print("解密失败:$err");
      return encrypted;
    }
  }
}
