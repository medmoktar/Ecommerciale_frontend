import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestion_locateur/Url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UsercommandeController extends GetxController {
  List commande = [];
  @override
  void onInit() {
    super.onInit();
  }

  getcommande() async {
    var response = await http.get(Uri.parse("${Url().url}/commande/All"));
    commande = jsonDecode(response.body);
    update();
  }

  updateStatus(BuildContext context, int id) async {
    Map<String, Object> data = {"id": id, "status": "VALIDE"};
    var response = await http.post(Uri.parse("${Url().url}/commande/status"),
        body: jsonEncode(data),
        headers: {
          "Content-Type": "application/json",
        });
    getcommande();
  }
}
