import 'dart:convert';

import 'package:gestion_locateur/Url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FactureController extends GetxController {
  late int id;
  List produit = [];
  Map<String, dynamic> facture = {};
  @override
  void onInit() {
    id = Get.arguments;
    get();
    super.onInit();
  }

  void get() async {
    var response = await http.get(Uri.parse("${Url().url}/facture/$id"));
    facture = jsonDecode(response.body);
    produit = facture["produits"];
    update();
  }
}
