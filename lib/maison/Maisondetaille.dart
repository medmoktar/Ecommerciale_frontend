import 'package:flutter/material.dart';
import 'package:gestion_locateur/Panier/Panier_controller.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Maisondetaille extends StatelessWidget {
  const Maisondetaille({super.key});

  @override
  Widget build(BuildContext context) {
    late PageController p = PageController(keepPage: true);
    late PanierController controller = Get.find();
    late Map<String, dynamic> L = Get.arguments;
    late List image = L['images'];
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Container(
            height: 250,
            child: PageView.builder(
              controller: p,
              itemCount: image.length,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage("${image[index]}"),
                          fit: BoxFit.cover)),
                );
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: SmoothPageIndicator(
              controller: p,
              count: image.length,
              effect: ExpandingDotsEffect(activeDotColor: Color(0xff7D4FFE)),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "33".tr + ": ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text(
                          "${L['nom']}",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        )
                      ],
                    ),
                    Text(
                      "${L['prix']} MRU",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(),
                Row(
                  children: [
                    Text(
                      "quantite:",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      " ${L['quantite'].toInt()} ",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "15".tr,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      "${L['description']}",
                      maxLines: 5,
                    )
                  ],
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "16".tr,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      "${L['tel']}",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    )
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        controller.panier.add(L);
                        controller.commande
                            .add({"maisonId": L['id'], "quantite": 1});
                        Get.snackbar("", "cette produit est ajouter au panier");
                        controller.misajour();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff7D4FFE),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Text("Ajouter au Panier")),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
