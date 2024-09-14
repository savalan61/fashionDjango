import 'package:fashion_django/common/utils/environment.dart';
import 'package:http/http.dart' as http;

class AuthServiceApi {
  Future<http.Response> signUp(String data) async {
    final url = Uri.parse('${Environment.appBaseUrl}/auth/users/');
    return await http.post(url, headers: {'Content-Type': 'application/json'}, body: data);
  }

  Future<http.Response> signIn(String data) async {
    final url = Uri.parse('${Environment.appBaseUrl}/auth/token/login');
    return await http.post(url, headers: {'Content-Type': 'application/json'}, body: data);
  }

  Future<http.Response> getUser(String accessToken) async {
    final url = Uri.parse('${Environment.appBaseUrl}/auth/users/me/');
    return await http.get(
      url,
      headers: {'Content-Type': 'application/json', 'Authorization': 'Token $accessToken'},
    );
  }
}
