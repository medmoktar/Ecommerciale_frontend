import 'package:flutter/material.dart';
import 'package:gestion_locateur/Facture/Facture_controller.dart';
import 'package:get/get.dart';

class FactureView extends StatelessWidget {
  const FactureView({super.key});

  @override
  Widget build(BuildContext context) {
    FactureController controller = Get.put(FactureController());
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
          child: GetBuilder<FactureController>(builder: (c) {
            return Card(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: Text("Paiement à réception"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Client: ${controller.facture["client"]}"),
                          Text("date: ${controller.facture["date"]}"),
                        ],
                      )),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Produit",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Quantité",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Prix ​​unitaire",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Prix total",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      ...List.generate(c.produit.length, (i) {
                        return Column(
                          children: [
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${controller.produit[i]["nom"]}",
                                ),
                                Text(
                                  "${controller.produit[i]["quantite"]}",
                                ),
                                Text(
                                  "${controller.produit[i]["prix"]}",
                                ),
                                Text(
                                  "${controller.produit[i]["prixtotal"]}",
                                )
                              ],
                            ),
                          ],
                        );
                      }),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Text(
                              "Prix total: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("${controller.facture["total"]}"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          })),
    );
  }
}
