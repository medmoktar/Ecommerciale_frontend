import 'dart:convert';

import 'package:gestion_locateur/Url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Maisoncontroller extends GetxController {
  List maison = [];
  bool t = false;
  String? selectlocalisation;
  List filtermaison = [];
  Future<void> All() async {
    var rep = await http.get(Uri.parse("${Url().url}/Api/auth/maison/All"));
    maison = jsonDecode(rep.body);
    filtermaison = maison;
    t = true;
    update();
  }

  filter(String l) {
    selectlocalisation = l;
    filtermaison = maison
        .where(
            (m) => m['nom'].toString().toLowerCase().contains(l.toLowerCase()))
        .toList();
    update();
  }

  list() {
    selectlocalisation = null;
    filtermaison = maison;
    update();
  }
}
