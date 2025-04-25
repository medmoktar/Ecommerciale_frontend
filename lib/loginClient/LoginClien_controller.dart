import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gestion_locateur/Url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginclienController extends GetxController {
  login(BuildContext context, TextEditingController email,
      TextEditingController password) async {
    Map<String, Object> body = {"tel": email.text, "password": password.text};
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    var rep = await http.post(Uri.parse("${Url().url}/client/login"),
        body: jsonEncode(body), headers: headers);
    if (rep.statusCode == 401) {
      AwesomeDialog(
        dismissOnTouchOutside: false,
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Error',
        desc: "Echec de l'authentification",
        btnOkOnPress: () {},
      ).show();
    } else {
      int id = jsonDecode(rep.body)["id"];
      Get.offAllNamed("/bottombar", arguments: id);
    }
  }
}
