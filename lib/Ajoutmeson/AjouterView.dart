import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gestion_locateur/Ajoutmeson/AjoutController.dart';

import 'package:get/get.dart';

// ignore: must_be_immutable
class Ajouterview extends StatelessWidget {
  final int id;
  Ajouterview({super.key, required this.id});

  TextEditingController localisation = TextEditingController();
  TextEditingController prix = TextEditingController();
  TextEditingController nom = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController quantite = TextEditingController();
  final Ajoutcontroller controller = Get.put(Ajoutcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffC49FFF),
          title: Text("6".tr, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              input("33".tr, nom, TextInputType.text),
              SizedBox(height: 10),
              input("8".tr, prix, TextInputType.number),
              SizedBox(
                height: 10,
              ),
              input("quantite", quantite, TextInputType.number),
              SizedBox(height: 10),
              input("9".tr, description, TextInputType.text),
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
                  onPressed: () => controller.pickImages(),
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
              GetBuilder<Ajoutcontroller>(builder: (c) {
                return Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(c.images.length, (i) {
                      return Stack(
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
                    if (prix.text.isEmpty ||
                        nom.text.isEmpty ||
                        description.text.isEmpty ||
                        controller.images.isEmpty) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: '12'.tr,
                        desc: '13'.tr,
                        btnOkOnPress: () {},
                      ).show();
                    } else {
                      controller.sendData(
                          context, id, nom, prix, quantite, description);
                      localisation.text = "";
                      prix.text = "";
                      description.text = "";
                      controller.images = [];
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

Widget input(
    String hint, TextEditingController controller, TextInputType type) {
  return TextField(
    controller: controller,
    keyboardType: type,
    decoration: InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
    ),
  );
}
