import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gestion_locateur/modifierInformt/modifier_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ModifierView extends StatelessWidget {
  const ModifierView({super.key});

  @override
  Widget build(BuildContext context) {
    ModifierController controller = Get.put(ModifierController());
    controller.getdata();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffC49FFF),
        onPressed: () {
          controller.determinePosition(context, controller.controler);
        },
        child: Icon(Icons.my_location),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xffC49FFF),
        title: Text("6".tr, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: ListView(
          children: [
            GetBuilder<ModifierController>(builder: (c) {
              return input("23".tr, controller.email, TextInputType.text);
            }),
            SizedBox(
              height: 20,
            ),
            GetBuilder<ModifierController>(builder: (c) {
              return input("27".tr, controller.tel, TextInputType.number);
            }),
            SizedBox(
              height: 20,
            ),
            GetBuilder<ModifierController>(
              builder: (c) {
                return Container(
                  height: 400,
                  child: GoogleMap(
                    initialCameraPosition:
                        CameraPosition(target: LatLng(18.098564, -15.958748)),
                    markers: {
                      Marker(
                          markerId: MarkerId("1"),
                          icon: BitmapDescriptor.defaultMarker,
                          position: LatLng(c.laltitude, c.longitude))
                    },
                    onMapCreated: (GoogleMapController _controller) {
                      if (!controller.controler.isCompleted) {
                        controller.controler.complete(_controller);
                      }
                    },
                    onTap: (position) {
                      if (c.controler.isCompleted) {
                        c.new_position(position, c.controler);
                      }
                    },
                  ),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  if (controller.email.text.isEmpty ||
                      controller.tel.text.isEmpty) {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.rightSlide,
                      title: '12'.tr,
                      desc: '13'.tr,
                      btnOkOnPress: () {},
                    ).show();
                  } else {
                    controller.sendData(context);
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
      ),
    );
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
