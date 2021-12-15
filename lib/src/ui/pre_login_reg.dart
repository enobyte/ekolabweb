import 'package:ekolabweb/src/ui/about.dart';
import 'package:ekolabweb/src/ui/login.dart';
import 'package:ekolabweb/src/utilities/string.dart';
import 'package:ekolabweb/src/utilities/utils.dart';
import 'package:ekolabweb/src/widget/button_widget.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';

class PreLoginRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Image.asset(logo),
        ),
        backgroundColor: Colors.white,
        actions: [
          TextButton(
              onPressed: () => routeToWidget(context, About()),
              child: TextWidget(
                txt: "Tentang",
                color: Colors.redAccent,
              )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
            child: ButtonWidget(
              txt: TextWidget(txt: "Masuk/Daftar"),
              height: 10.0,
              width: 130.0,
              btnColor: Colors.redAccent,
              onClick: () => routeToWidget(context, Login()),
              borderRedius: 4.0,
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            Container(
              color: Colors.redAccent,
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Wrap(
                direction: Axis.vertical,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    child: TextWidget(
                      txt: "Selamat Datang di Ekolab",
                      color: Colors.white,
                      fontFamily: 'Bold',
                      txtSize: 18,
                      align: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8),
                    child: TextWidget(
                      txt: about,
                      txtSize: 16,
                      color: Colors.white,
                      align: TextAlign.start,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      txt: "Pewaralaba",
                                      fontFamily: 'Bold',
                                      align: TextAlign.start,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6),
                                      child: TextWidget(
                                          txt: descPerawalaba,
                                          align: TextAlign.start),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 16, right: 16),
                                      child: Divider(
                                        height: 2,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Image.asset(
                                icPewaralaba,
                                height: 50,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      txt: "Konsinyor",
                                      fontFamily: 'Bold',
                                      align: TextAlign.start,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6),
                                      child: TextWidget(
                                          txt: descKonsiyor,
                                          align: TextAlign.start),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 16, right: 16),
                                      child: Divider(
                                        height: 2,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Image.asset(
                                icKonsinyor,
                                height: 50,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      txt: "UKM/UMK",
                                      fontFamily: 'Bold',
                                      align: TextAlign.start,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6),
                                      child: TextWidget(
                                          txt: descUKM, align: TextAlign.start),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 16, right: 16),
                                      child: Divider(
                                        height: 2,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Image.asset(
                                icUkm,
                                height: 50,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    flex: 5,
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      txt: "Investor",
                                      fontFamily: 'Bold',
                                      align: TextAlign.start,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6),
                                      child: TextWidget(
                                          txt: descInvestor,
                                          align: TextAlign.start),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16),
                                      child: Divider(
                                        height: 2,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Image.asset(
                                icInvestor,
                                height: 50,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      txt: "Jejaring Organisasi",
                                      fontFamily: 'Bold',
                                      align: TextAlign.start,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6),
                                      child: TextWidget(
                                          txt: descJejaring,
                                          align: TextAlign.start),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16),
                                      child: Divider(
                                        height: 2,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Image.asset(
                                icJejaring,
                                height: 50,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      txt: "Perizinan",
                                      fontFamily: 'Bold',
                                      align: TextAlign.start,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6),
                                      child: TextWidget(
                                        txt: descPerizinan,
                                        align: TextAlign.start,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16),
                                      child: Divider(
                                        height: 2,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Image.asset(
                                icPersetujuan,
                                height: 50,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    flex: 5,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
