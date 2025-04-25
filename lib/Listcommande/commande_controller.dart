import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gestion_locateur/Url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CommandeController extends GetxController {
  List commande = [];
  @override
  void onInit() {
    super.onInit();
  }

  getcommande(int id_client) async {
    var response =
        await http.get(Uri.parse("${Url().url}/client/commande/$id_client"));
    commande = jsonDecode(response.body)["commandes"];
    update();
  }

  updateStatus(BuildContext context, int id, int id_client) async {
    Map<String, Object> data = {"id": id, "status": "ANNULEE"};
    var response = await http.post(Uri.parse("${Url().url}/commande/status"),
        body: jsonEncode(data),
        headers: {
          "Content-Type": "application/json",
        });
    getcommande(id_client);
  }
}
