import 'package:ekolabweb/src/bloc/product_bloc.dart';
import 'package:ekolabweb/src/model/product_model.dart';
import 'package:ekolabweb/src/utilities/utils.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';

import 'space/list_product.dart';

class SearchMain extends SearchDelegate {
  final String idUser;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear, color: Colors.black),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel => 'Pencarian Produk';

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    bloc.getProductByNameList({"name": query.toLowerCase(), "id_user": idUser});
    return Container(
      child: StreamBuilder<ProductModel>(
          stream: bloc.getProductByName,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.data!.length > 0) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => routeToWidget(
                          context,
                          ListProduct(
                              false, snapshot.data!.data![index]["id_user"])),
                      child: Card(
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextWidget(
                                txt: snapshot.data!.data![index]["data"]
                                    ["name"],
                                txtSize: 18,
                                align: TextAlign.start,
                              ),
                              Icon(Icons.arrow_forward_ios)
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: snapshot.data?.data?.length ?? 0,
                );
              } else {
                return Container();
              }
            }
            return Container();
          }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SizedBox();
  }

  SearchMain(this.idUser);
}
