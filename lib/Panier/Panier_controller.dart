import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gestion_locateur/Url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PanierController extends GetxController {
  List panier = [];
  List commande = [];
  misajour() {
    update();
  }

  void incremente(int i) {
    int j = commande[i]["quantite"];
    j++;
    commande[i]["quantite"] = j;
    print("quantite= ${commande[i]["quantite"]}");
    update();
  }

  void decremente(int i) {
    int j = commande[i]["quantite"];
    if (j > 1) {
      j--;
      commande[i]["quantite"] = j;
      print("${commande}");
      update();
    }
  }

  void remove(int i) {
    commande.removeAt(i);
    panier.removeAt(i);
    update();
  }

  commander(BuildContext context, int id_client) async {
    late double prix_total = 0;
    late int p;
    late int q;
    for (int i = 0; i < commande.length; i++) {
      p = panier[i]["prix"].toInt();
      q = commande[i]["quantite"];
      prix_total += p * q;
    }
    Map<String, Object> date = {"prix_total": prix_total, "maisons": commande};
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
          update();
        },
      ).show();
    } else {
      print("status ${response.statusCode} $body");
    }
  }
}
