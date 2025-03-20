import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestion_locateur/Url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';

class Logincontroller extends GetxController {
  late int id;
  late String tel;
  late String _email;
  login(BuildContext context, TextEditingController email,
      TextEditingController password) async {
    Map<String, Object> body = {"email": email.text, "password": password.text};
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    var rep = await http.post(Uri.parse("${Url().url}/Api/auth/login"),
        body: jsonEncode(body), headers: headers);
    if (rep.statusCode != 200) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Error',
        desc: "Echec de l'authentification",
        btnOkOnPress: () {},
      ).show();
    } else {
      var list = jsonDecode(rep.body);
      id = list['user_id'];
      tel = list['tel'];
      _email = list['email'];
      List info = [id, tel, _email];
      Get.offAllNamed("/user/bottombar", arguments: info);
    }
  }
}
