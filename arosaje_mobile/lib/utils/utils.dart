import 'package:arosaje_mobile/models/user.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class Utils {
  static Map<String, dynamic> getPayloadFromToken(String jwtToken) {
    return JwtDecoder.decode(jwtToken);
  }

  static bool isTokenExpire(String jwtToken) {
    return JwtDecoder.isExpired(jwtToken);
  }
}
