import 'dart:async';
import 'package:get/get.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gestion_locateur/UserUpdateMaison/Updatecontroller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Updateview extends StatelessWidget {
  const Updateview({super.key});

  @override
  Widget build(BuildContext context) {
    final Completer<GoogleMapController> controler =
        Completer<GoogleMapController>();
    TextEditingController nom = TextEditingController();
    TextEditingController prix = TextEditingController();
    TextEditingController description = TextEditingController();
    final Updatecontroller controller = Get.put(Updatecontroller());
    final Map<String, dynamic> L = Get.arguments;
    nom.text = L['nom'];
    prix.text = L['prix'].toString();
    description.text = L['description'];
    late List images = L['images'];
    late var id = L['id'];

    return Scaffold(
        appBar: AppBar(
          title: Text("19".tr, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              input("7".tr, nom),
              SizedBox(height: 10),
              input("8".tr, prix),
              SizedBox(height: 10),
              input("9".tr, description),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () => controller.pickeimage(),
                  child: Column(
                    children: [
                      Text("10".tr),
                      Icon(
                        Icons.download,
                        color: Colors.white,
                        size: 30,
                      )
                    ],
                  )),
              SizedBox(
                height: 10,
              ),
              GetBuilder<Updatecontroller>(builder: (c) {
                return Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(
                        c.images.isEmpty ? images.length : c.images.length,
                        (i) {
                      return c.images.isEmpty
                          ? Image.network(
                              images[i].toString(),
                              fit: BoxFit.cover,
                              height: 100,
                              width: 110,
                            )
                          : Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Image.file(
                                  c.images[i],
                                  fit: BoxFit.cover,
                                  height: 100,
                                  width: 110,
                                ),
                                InkWell(
                                  onTap: () {
                                    c.remove(i);
                                  },
                                  child: Container(
                                    color: Colors.red,
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            );
                    }));
              }),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (nom.text.isEmpty ||
                        prix.text.isEmpty ||
                        nom.text.isEmpty) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: '12'.tr,
                        desc: '13'.tr,
                        btnOkOnPress: () {},
                      ).show();
                    } else {
                      controller.sendData(context, id, nom, prix, description);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff7D4FFE),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Text("11".tr))
            ],
          ),
        ));
  }
}

Widget input(String hint, TextEditingController controller) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
    ),
  );
}
