import 'dart:async';
import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gestion_locateur/Url.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class ModifierController extends GetxController {
  late double laltitude = 18.098564;
  late double longitude = -15.958748;
  static LatLng currentps = LatLng(37.77498, -122.4194);
  int id = Get.arguments;
  TextEditingController email = TextEditingController();
  TextEditingController tel = TextEditingController();
  final Completer<GoogleMapController> controler =
      Completer<GoogleMapController>();
  @override
  void onInit() {
    getdata();
    super.onInit();
  }

  determinePosition(BuildContext context, controller) async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'active la localisation',
        btnOkOnPress: () {},
      ).show();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return null;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();
    laltitude = position.latitude;
    longitude = position.longitude;

    currentps = LatLng(laltitude, longitude);
    _goToPosition(currentps, controller);
    update();
  }

  Future<void> _goToPosition(p, controller) async {
    // ignore: no_leading_underscores_for_local_identifiers
    final GoogleMapController _controller = await controller.future;
    _controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: p, zoom: 14.4746)));
  }

  new_position(LatLng position, controller) {
    laltitude = position.latitude;
    longitude = position.longitude;
    _goToPosition(position, controller);
    update();
  }

  Map<String, dynamic> inf = {};
  getdata() async {
    var rep = await http.get(Uri.parse("${Url().url}/findByid/$id"));
    inf = jsonDecode(rep.body);
    email.text = inf["user"]["email"];
    tel.text = inf["user"]["tel"];
    new_position(LatLng(inf["user"]["altd"], inf["user"]["longd"]), controler);
    update();
  }

  sendData(BuildContext context) async {
    Map<String, Object> body = {
      "email": email.text,
      "tel": tel.text,
      "altd": laltitude,
      "longd": longitude,
    };
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    var rep = await http.put(Uri.parse("${Url().url}/update/$id"),
        body: jsonEncode(body), headers: headers);
    if (rep.statusCode == 200) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: 'Success',
        desc: 'la maison ajouter avec success',
        btnOkOnPress: () {},
      ).show();
    } else {
      print("=========${rep.statusCode}:$rep==========");
    }
  }
}
