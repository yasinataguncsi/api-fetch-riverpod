import 'dart:convert';

import 'package:http/http.dart';

import '../models/user.dart';

class ApiServices {
  String userURL = "https://reqres.in/api/users?page=2";

  getUsers() async {
    /// get data from here.
    ///
    Response response = await get(Uri.parse(userURL));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      return result.map((e) => User.fromJson(e)).toList();

      ///
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
