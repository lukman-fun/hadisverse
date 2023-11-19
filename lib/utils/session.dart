import 'package:hadisverse/models/jwt_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static String KEY_JWT = 'key_jwt';

  Future<void> save(Jwt jwt) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(KEY_JWT, jwtToJson(jwt));
  }

  Future<Jwt?> get() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return jwtFromJson(preferences.getString(KEY_JWT).toString());
  }

  Future<void> unset() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(KEY_JWT);
  }

}
