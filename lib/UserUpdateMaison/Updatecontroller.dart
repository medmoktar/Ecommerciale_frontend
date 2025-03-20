import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'package:gestion_locateur/Url.dart';
import 'package:gestion_locateur/usermaison/UsermaisonController.dart';
import 'package:gestion_locateur/usermaison/Usermaisondetaille/Maisondetaillecontroller.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class Updatecontroller extends GetxController {
  late ImagePicker picker = ImagePicker();
  late List<File> images = [];

  pickeimage() async {
    List<XFile> image = await picker.pickMultiImage();
    // ignore: unnecessary_null_comparison
    if (image.length != null && image.length < 6) {
      images = image.map((file) => File(file.path)).toList();
      update();
    } else {
      Get.snackbar("error", "vous pouver selectionner jusqu'a 5 photos");
    }
  }

  void remove(int index) {
    images.removeAt(index);
    update();
  }

  Future<void> sendData(BuildContext context, int id, TextEditingController nom,
      TextEditingController prix, TextEditingController desc) async {
    final Map<String, String> headers = {'Content-Type': 'multipart/form-data'};
    var url = Uri.parse("${Url().url}/Api/auth/maison/modifier/$id");
    var req = http.MultipartRequest('PATCH', url);
    req.fields['nom'] = nom.text;
    req.fields['prix'] = prix.text;
    req.fields['description'] = desc.text;
    req.headers.addAll(headers);
    if (images.isNotEmpty) {
      for (var i in images) {
        req.files.add(await http.MultipartFile.fromPath("images", i.path));
      }
    }
    try {
      var rep = await req.send();
      if (rep.statusCode == 200) {
        final usermaisonController = Get.find<Usermaisoncontroller>();
        usermaisonController.update();
        update();
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Success',
          desc: 'la maison modifier avec success',
          btnOkOnPress: () {
            Get.back();
            Get.find<Maisondetaillecontroller>().getbyid(id);
          },
        ).show();
      } else {
        print("=============${rep.statusCode}=======");
      }
    } catch (e) {
      print("============erreur:$e=============");
    }
  }
}
