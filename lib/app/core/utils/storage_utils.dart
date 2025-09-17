import 'package:get_storage/get_storage.dart';
import 'package:quick_order_app/app/data/models/user_model.dart';

class StorageUtils {
  static final _box = GetStorage();

  static const String _tokenKey = 'authToken';
  static const String _userKey = 'userData';

  static Future<void> saveToken(String token) async {
    await _box.write(_tokenKey, token);
  }

  static String? getToken() {
    return _box.read<String>(_tokenKey);
  }

  static Future<void> saveUser(UserModel user) async {
    await _box.write(_userKey, user.toJson());
  }

  static UserModel? getUser() {
    final data = _box.read<Map<String, dynamic>>(_userKey);
    if (data != null) {
      return UserModel.fromJson(data);
    }
    return null;
  }

  static Future<void> clear() async {
    await _box.remove(_tokenKey);
    await _box.remove(_userKey);
  }
}