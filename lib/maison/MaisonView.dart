import 'package:flutter/material.dart';
import 'package:gestion_locateur/maison/Maisoncontroller.dart';
import 'package:get/get.dart';

class Maisonview extends StatelessWidget {
  const Maisonview({super.key});

  @override
  Widget build(BuildContext context) {
    final Maisoncontroller controller = Get.put(Maisoncontroller());
    controller.All();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: GetBuilder<Maisoncontroller>(builder: (c) {
          return AppBar(
              backgroundColor: Color(0xFFC49FFF),
              title: Text(
                "4".tr,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: c.selectlocalisation != null
                  ? IconButton(
                      onPressed: () {
                        c.list();
                      },
                      icon: Icon(Icons.arrow_back))
                  : null);
        }),
      ),
      body: GetBuilder<Maisoncontroller>(builder: (c) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              SearchAnchor.bar(
                barHintText: "3".tr,
                barShape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
                suggestionsBuilder:
                    (context, SearchController searchcontroller) {
                  final String input = searchcontroller.value.text;
                  return controller.maison
                      .where((p) => p['nom']
                          .toString()
                          .toLowerCase()
                          .contains(input.toLowerCase()))
                      .map((p) => Card(
                            child: ListTile(
                              title: Text(p['nom'].toString()),
                              onTap: () {
                                searchcontroller.closeView(p['nom']);
                                c.filter(p['nom']);
                              },
                            ),
                          ))
                      .toList();
                },
              ),
              SizedBox(
                height: 10,
              ),
              GridView.builder(
                shrinkWrap:
                    true, // Ajouté pour empêcher le conflit avec ListView
                physics: NeverScrollableScrollPhysics(),
                itemCount: c.filtermaison.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, i) {
                  return c.t == false
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : InkWell(
                          onTap: () {
                            Get.toNamed("maison/detaille",
                                arguments: c.filtermaison[i]);
                          },
                          child: Card(
                            margin: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // SizedBox(
                                //   height: 10,
                                // ),
                                Container(
                                  height: 120,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "${c.filtermaison[i]['images'][0]}"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${c.filtermaison[i]['nom']}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.04,
                                      ),
                                    ),
                                    Text(
                                      "${c.filtermaison[i]["prix"]} MRU",
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
