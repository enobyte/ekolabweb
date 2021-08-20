import 'package:ekolabweb/src/bloc/product_bloc.dart';
import 'package:ekolabweb/src/model/submission_model.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/responsive_table.dart';

class ListPenawaranAdmin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListPenawaranAdminState();
  }
}

class _ListPenawaranAdminState extends State<ListPenawaranAdmin> {
  List<DatatableHeader> _header = [
    DatatableHeader(text: "No", value: "no", sortable: true),
    DatatableHeader(text: "Nama Produk", value: "name", sortable: true),
    DatatableHeader(text: "Tanggal Pengajuan", value: "date", sortable: true),
  ];
  List<Map<String, dynamic>> _source = [];

  @override
  void initState() {
    super.initState();
    bloc.getAllSubmissionRequest();
  }

  List<int> _perPages = [5, 10, 15, 100];
  int _total = 100;
  int? _currentPerPage;
  int _currentPage = 1;

  @override
  void dispose() {
    super.dispose();
    _source.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: TextWidget(
            txt: "List Penawaran",
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(0),
                constraints: BoxConstraints(
                  maxHeight: 700,
                ),
                child: Card(
                  child: StreamBuilder<SubmissionModel>(
                      stream: bloc.getAllSubmissionProduct,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          _source.clear();
                          var i = 1;
                          for (var v in snapshot.data!.data!) {
                            _source.add({
                              "no": i++,
                              "name": v["product"]["name"],
                              "date": DateTime.now()
                            });
                          }
                          return ResponsiveDatatable(
                            headers: _header,
                            source: _source,
                            autoHeight: false,
                            footers: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text("Rows per page:"),
                              ),
                              if (_perPages != null)
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: DropdownButton(
                                      value: _currentPerPage,
                                      items: _perPages
                                          .map((e) => DropdownMenuItem(
                                                child: Text("$e"),
                                                value: e,
                                              ))
                                          .toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          _currentPerPage = value as int?;
                                        });
                                      }),
                                ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                    "$_currentPage - $_currentPerPage of $_total"),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  size: 16,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _currentPage = _currentPage >= 2
                                        ? _currentPage - 1
                                        : 1;
                                  });
                                },
                                padding: EdgeInsets.symmetric(horizontal: 15),
                              ),
                              IconButton(
                                icon: Icon(Icons.arrow_forward_ios, size: 16),
                                onPressed: () {
                                  setState(() {
                                    _currentPage++;
                                  });
                                },
                                padding: EdgeInsets.symmetric(horizontal: 15),
                              )
                            ],
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      }),
                ),
              )
            ],
          ),
        ));
  }
}
