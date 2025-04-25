import 'package:flutter/material.dart';
import 'package:gestion_locateur/BottomNavigation/BottomController.dart';
import 'package:gestion_locateur/Listcommande/commande_controller.dart';
import 'package:gestion_locateur/Listcommande/commande_view.dart';
import 'package:gestion_locateur/Panier/Panier_controller.dart';
import 'package:gestion_locateur/Panier/Panier_view.dart';
import 'package:gestion_locateur/maison/MaisonView.dart';
import 'package:gestion_locateur/setting/SettingView.dart';
import 'package:get/get.dart';

class Bottombarview extends StatelessWidget {
  Bottombarview({super.key});

  final Bottomcontroller controller = Get.put(Bottomcontroller());
  final PanierController c = Get.put(PanierController());
  final CommandeController commande = Get.put(CommandeController());
  @override
  Widget build(BuildContext context) {
    int id = Get.arguments;
    final List<Widget> screens = [
      Maisonview(),
      PanierView(
        id_client: id,
      ),
      CommandeView(
        id_client: id,
      ),
      Settingview()
    ];
    return Scaffold(
      body: GetBuilder<Bottomcontroller>(builder: (controller) {
        return screens[controller.index];
      }),
      bottomNavigationBar: GetBuilder<Bottomcontroller>(builder: (controller) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "1".tr),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart,
                ),
                label: "34".tr),
            BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: "35".tr),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "2".tr),
          ],
          currentIndex: controller.index,
          onTap: (i) {
            controller.changeIndex(i);
          },
        );
      }),
    );
  }
}
