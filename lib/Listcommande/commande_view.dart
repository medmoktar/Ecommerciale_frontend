import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gestion_locateur/Listcommande/commande_controller.dart';
import 'package:get/get.dart';

class CommandeView extends StatelessWidget {
  final int id_client;
  const CommandeView({super.key, required this.id_client});

  @override
  Widget build(BuildContext context) {
    CommandeController controller = Get.find();
    controller.getcommande(id_client);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: GetBuilder<CommandeController>(builder: (c) {
            return ListView.builder(
              itemCount: c.commande.length,
              itemBuilder: (BuildContext context, int i) {
                return Card(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: c.commande[i]["status"] == "ENCOURS"
                          ? Row(
                              children: [
                                Expanded(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          c.commande[i]["localisation"] ?? "",
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          c.commande[i]["tel"] ?? "",
                                          maxLines: 1,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          c.commande[i]["status"] ?? "",
                                        ),
                                        Text(
                                          c.commande[i]["date_commande"] ?? "",
                                        ),
                                      ]),
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      AwesomeDialog(
                                              context: context,
                                              dismissOnTouchOutside: false,
                                              dialogType: DialogType.question,
                                              animType: AnimType.rightSlide,
                                              title: 'Tu est sur',
                                              desc:
                                                  "Tu veut annulee le commande ",
                                              btnOkOnPress: () {
                                                c.updateStatus(
                                                    context,
                                                    c.commande[i]["id"],
                                                    id_client);
                                              },
                                              btnCancelOnPress: () {})
                                          .show();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xff7D4FFE),
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    child: Text("Annuler"),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      Get.toNamed("facture",
                                          arguments: c.commande[i]["id"]);
                                    },
                                    icon: Icon(Icons.visibility))
                              ],
                            )
                          : Row(
                              children: [
                                Expanded(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          c.commande[i]["localisation"] ?? "",
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          c.commande[i]["tel"] ?? "",
                                          maxLines: 1,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          c.commande[i]["status"] ?? "",
                                        ),
                                        Text(
                                          c.commande[i]["date_commande"] ?? "",
                                        ),
                                      ]),
                                ),
                                IconButton(
                                    onPressed: () {
                                      Get.toNamed("facture",
                                          arguments: c.commande[i]["id"]);
                                    },
                                    icon: Icon(Icons.visibility))
                              ],
                            )),
                );
              },
            );
          })),
    );
  }
}
