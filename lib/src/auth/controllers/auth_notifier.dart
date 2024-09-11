// import 'dart:convert';
//
// import 'package:fashion_django/common/services/storage.dart';
// import 'package:fashion_django/common/utils/app_routes.dart';
// import 'package:fashion_django/common/utils/environment.dart';
// import 'package:fashion_django/common/utils/kstrings.dart';
// import 'package:fashion_django/common/widgets/error_modal.dart';
// import 'package:fashion_django/src/auth/models/access_token_model.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:go_router/go_router.dart';
// import "package:http/http.dart" as http;
// import 'package:provider/provider.dart';
//
// import '../../entrypoint/controllers/bottom_tab_notifier.dart';
//
// class AuthNotifier with ChangeNotifier {
//   bool _isLoading = false;
//   get isLoading => _isLoading;
//   void setIsLoading() {
//     _isLoading = !_isLoading;
//     notifyListeners();
//   }
//
//   void signInFunction(String data, BuildContext context) async {
//     setIsLoading();
//     try {
//       var url = Uri.parse("${Environment.appBaseUrl}/auth/token/login");
//       // var url = Uri.parse("http://10.0.2.2:8000/auth/token/login/");
//       var res = await http.post(url, headers: {'Content-Type': 'application/json'}, body: data);
//       if (res.statusCode == 200) {
//         String accessToken = accessTokenModelFromJson(res.body).authToken;
//         getUser(accessToken, context);
//       }
//     } catch (e) {
//       showErrorPopup(context, AppText.kErrorLogin, null, null);
//     } finally {
//       setIsLoading();
//     }
//   }
//
//   void signUpFunction(String data, BuildContext context) async {
//     setIsLoading();
//     try {
//       var url = Uri.parse("${Environment.appBaseUrl}/auth/users");
//       var res = await http.post(url, headers: {'Content-Type': 'application/json'}, body: data);
//       if (res.statusCode == 201) {
//         setIsLoading();
//       } else if (res.statusCode == 400) {
//         setIsLoading();
//         var data = jsonDecode(res.body);
//         showErrorPopup(context, data["password"][0], null, null);
//       }
//     } catch (e) {
//       setIsLoading();
//       showErrorPopup(context, AppText.kErrorLogin, null, null);
//       print(e);
//     }
//   }
//
//   void getUser(String accessToken, BuildContext context) async {
//     try {
//       var url = Uri.parse("http://10.0.2.2:8000/auth/users/me/");
//       var res =
//           await http.get(url, headers: {'Content-Type': 'application/json', 'Authorization': 'Token $accessToken'});
//       if (res.statusCode == 200) {
//         Storage().setString("accessToken", accessToken);
//         // Storage().setString(accessToken, res.body);
//         notifyListeners();
//         context.read<BottomTabNotifier>().setTabIndex(0);
//         context.go("/home");
//       }
//     } catch (e) {
//       showErrorPopup(context, AppText.kErrorLogin, null, null);
//     }
//   }
// }
