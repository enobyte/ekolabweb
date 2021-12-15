import 'package:ekolabweb/src/bloc/admin_bloc.dart';
import 'package:ekolabweb/src/model/rekap_user_model.dart';
import 'package:ekolabweb/src/utilities/string.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';

class RekapKategoriProduct extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RekapKategoriProductState();
  }
}

class _RekapKategoriProductState extends State<RekapKategoriProduct> {
  @override
  void initState() {
    super.initState();
    bloc.fetchRekapKatProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(txt: "Rekap Kategori Produk"),
      ),
      body: Container(
        child: StreamBuilder<RekapUserModel>(
            stream: bloc.rekapKatProduct,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextWidget(
                              txt: snapshot.data!.data![index].total.toString(),
                              txtSize: 25,
                            ),
                            TextWidget(
                              txt: snapshot.data!.data![index].name.toString(),
                              txtSize: 18,
                              color: colorBase,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: snapshot.data?.data?.length ?? 0,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
