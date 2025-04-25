import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/widgets.dart';
import 'package:gestion_locateur/Panier/Panier_controller.dart';
import 'package:gestion_locateur/Url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CommanderController extends GetxController {
  Map<String, dynamic> d = Get.arguments;
  List panier = [];
  List commande = [];
  late TextEditingController tel;
  late TextEditingController loc;
  late int id_client;
  @override
  void onInit() {
    tel = TextEditingController();
    loc = TextEditingController();
    panier = d['panier'];
    commande = d['commande'];
    id_client = d['id_client'];
    super.onInit();
  }

  commander(BuildContext context) async {
    late double prix_total = 0;
    late int p;
    late int q;
    for (int i = 0; i < commande.length; i++) {
      p = panier[i]["prix"].toInt();
      q = commande[i]["quantite"];
      prix_total += p * q;
    }
    Map<String, Object> date = {
      "prix_total": prix_total,
      "tel": tel.text,
      "localisation": loc.text,
      "maisons": commande
    };
    var response = await http.post(
      Uri.parse("${Url().url}/commande/add/$id_client"),
      body: jsonEncode(date),
      headers: {
        "Content-Type": "application/json",
      },
    );
    var body = jsonDecode(response.body);
    if (response.statusCode == 400) {
      AwesomeDialog(
        dismissOnTouchOutside: false,
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Error',
        desc: "${body["error"]}",
        btnOkOnPress: () {},
      ).show();
    } else if (response.statusCode == 200) {
      AwesomeDialog(
        dismissOnTouchOutside: false,
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: 'Success',
        desc: "Commande lancer avec success",
        btnOkOnPress: () {
          commande = [];
          panier = [];
          PanierController p = Get.find();
          p.commande = [];
          p.panier = [];
          Get.back();
          p.update();
          update();
        },
      ).show();
    } else {
      print("status ${response.statusCode} $body");
    }
  }
}
