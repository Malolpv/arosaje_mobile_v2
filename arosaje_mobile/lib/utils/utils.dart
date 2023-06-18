import 'package:arosaje_mobile/models/user.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class Utils {
  static User getPayloadFromToken(String jwtToken) {
    return User.fromJson(JwtDecoder.decode(jwtToken));
  }
}
