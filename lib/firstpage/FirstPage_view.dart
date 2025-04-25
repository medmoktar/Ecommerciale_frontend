import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirstpageView extends StatelessWidget {
  const FirstpageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/logo.png"), fit: BoxFit.cover),
                ),
              ),
            ),
            Spacer(),
            Container(
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed("/login");
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff7D4FFE),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Text("admin")),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed("/AuthenticationView");
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff7D4FFE),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Text("Visiteur")),
            )
          ],
        ),
      ),
    );
  }
}
