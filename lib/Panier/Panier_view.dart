import 'package:flutter/material.dart';
import 'package:gestion_locateur/Panier/Panier_controller.dart';
import 'package:get/get.dart';

class PanierView extends StatelessWidget {
  final int id_client;
  const PanierView({super.key, required this.id_client});

  @override
  Widget build(BuildContext context) {
    PanierController controller = Get.find();
    return Scaffold(
        appBar: AppBar(),
        body: GetBuilder<PanierController>(builder: (c) {
          return c.panier.isNotEmpty
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: ListView(
                    children: [
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.panier.length,
                          itemBuilder: (context, i) {
                            return Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(bottom: 20),
                              child: Row(
                                children: [
                                  Container(
                                    height: 120,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "${controller.panier[i]["images"][0]}"),
                                            fit: BoxFit.cover)),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        controller.panier[i]["nom"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                c.incremente(i);
                                              },
                                              icon: Icon(Icons
                                                  .add_circle_outline_outlined)),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(controller.commande[i]
                                                  ["quantite"]
                                              .toString()),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                controller.decremente(i);
                                              },
                                              icon: Icon(Icons
                                                  .remove_circle_outline_outlined)),
                                        ],
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            controller.remove(i);
                                          },
                                          icon: Icon(
                                            Icons
                                                .remove_circle_outline_outlined,
                                            color: Colors.grey,
                                          )),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${controller.panier[i]["prix"]} MRU",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              // controller.commander(context, id_client);
                              Get.toNamed("commander", arguments: {
                                "panier": c.panier,
                                "commande": c.commande,
                                "id_client": id_client
                              });
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
                )
              : Center(
                  child: Text("aucun produit"),
                );
        }));
  }
}
