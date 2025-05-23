import 'package:gestion_locateur/BottomNavigation/BottombarView.dart';
import 'package:gestion_locateur/Authentication/Authentication.dart';
import 'package:gestion_locateur/Facture/Facture_view.dart';
import 'package:gestion_locateur/UserBottombar/UserBottombarView.dart';
import 'package:gestion_locateur/UserUpdateMaison/UpdateView.dart';
import 'package:gestion_locateur/commander/Commander_view.dart';
import 'package:gestion_locateur/firstpage/FirstPage_view.dart';
import 'package:gestion_locateur/localisation/Localisationview.dart';
import 'package:gestion_locateur/login/LoginView.dart';
import 'package:gestion_locateur/maison/Maisondetaille.dart';
import 'package:gestion_locateur/modifierInformt/modifier_view.dart';
import 'package:gestion_locateur/translate/TranslateView.dart';
import 'package:gestion_locateur/translate/TranslationContrller.dart';
import 'package:gestion_locateur/usermaison/Usermaisondetaille/Usermaisondetaille.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(Translationcontrller());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      translations: Translateview(),
      locale: Locale("fr"),
      getPages: [
        GetPage(name: "/login", page: () => Loginview()),
        GetPage(name: "/AuthenticationView", page: () => AuthenticationView()),
        GetPage(name: "/", page: () => FirstpageView()),
        GetPage(name: "/bottombar", page: () => Bottombarview()),
        GetPage(name: "/user/bottombar", page: () => UserBottombarview()),
        GetPage(
            name: "/user/maison/detaille", page: () => Usermaisondetaille()),
        GetPage(name: "/maison/detaille", page: () => Maisondetaille()),
        GetPage(name: "/localisaton", page: () => Localisationview()),
        GetPage(name: "/maison/update", page: () => Updateview()),
        GetPage(name: "/information/update", page: () => ModifierView()),
        GetPage(name: "/commander", page: () => CommanderView()),
        GetPage(name: "/facture", page: () => FactureView())
      ],
    );
  }
}
