import 'dart:convert';

import 'package:http/http.dart';

import '../models/user.dart';

class ApiServices {
  String userURL = "https://reqres.in/api/users?page=2";

  /// DİO İLE YAP ABİSİ
  getUsers() async {
    /// GET DATA RESPONSE
    Response response = await get(Uri.parse(userURL));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['dasdasd'];
      return result.map((e) => User.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
