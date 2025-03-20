import 'dart:convert';

import 'package:gestion_locateur/Url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Usermaisoncontroller extends GetxController {
  List maison = [];
  bool t = false;
  get(int id) async {
    var rep =
        await http.get(Uri.parse("${Url().url}/Api/auth/maison/Affiche/$id"));
    maison = jsonDecode(rep.body);
    t = true;
    update();
  }

  Future<void> delete(id) async {
    await http.delete(Uri.parse("${Url().url}/Api/auth/maison/delete/$id"));
    update();
  }
}
