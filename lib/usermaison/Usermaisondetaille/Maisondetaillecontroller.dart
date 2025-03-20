import 'dart:convert';

import 'package:gestion_locateur/Url.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class Maisondetaillecontroller extends GetxController {
  late Map<String, dynamic> m = {};
  late List image = [];
  Future<void> getbyid(int id) async {
    var rep =
        await http.get(Uri.parse("${Url().url}/Api/auth/maison/find/$id"));
    m = jsonDecode(rep.body);
    image = m['images'];
    update();
  }
}
