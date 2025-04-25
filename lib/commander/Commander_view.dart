import 'package:flutter/material.dart';
import 'package:gestion_locateur/commander/Commander_controller.dart';
import 'package:get/get.dart';

class CommanderView extends StatelessWidget {
  const CommanderView({super.key});

  @override
  Widget build(BuildContext context) {
    CommanderController controller = Get.put(CommanderController());
    final GlobalKey<FormState> key = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: key,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: [
              input("27".tr, controller.tel, TextInputType.phone, (value) {
                if (value!.isEmpty) {
                  return "numero de tele phone requis";
                }
                return "";
              }),
              SizedBox(
                height: 10,
              ),
              input("14".tr, controller.loc, TextInputType.text, (value) {
                if (value!.isEmpty) {
                  return "localisation requis";
                }
                return "";
              }),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [],
              ),
              Spacer(),
              Container(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        controller.commander(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff7D4FFE),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Text("suivant")),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget input(String hint, TextEditingController controller, TextInputType type,
    final FormFieldValidator<String> validator) {
  return TextFormField(
    validator: validator,
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
