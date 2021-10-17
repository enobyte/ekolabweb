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
              width: 130,
              btnColor: Colors.redAccent,
              onClick: () => routeToWidget(context, Login()),
              borderRedius: 4,
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
              height: MediaQuery.of(context).size.height / 5,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(txt: "Pewaralaba", fontFamily: 'Bold',),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: TextWidget(txt: descPerawalaba, align: TextAlign.start),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 16, right: 16),
                                child: Divider(
                                  height: 2,
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(txt: "Konsinyor", fontFamily: 'Bold',),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: TextWidget(txt: descKonsiyor, align: TextAlign.start),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 16, right: 16),
                                child: Divider(
                                  height: 2,
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(txt: "UKM/UMK", fontFamily: 'Bold',),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: TextWidget(txt: descUKM, align: TextAlign.start),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16, right: 16),
                                child: Divider(
                                  height: 2,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    flex: 5,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(txt: "Investor", fontFamily: 'Bold',),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: TextWidget(txt: descInvestor, align: TextAlign.start),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Divider(
                                  height: 2,
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(txt: "Jejaring Organisasi", fontFamily: 'Bold',),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: TextWidget(txt: descJejaring, align: TextAlign.start),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Divider(
                                  height: 2,
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(txt: "Perizinan", fontFamily: 'Bold',),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: TextWidget(txt: descPerizinan, align: TextAlign.start,),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Divider(
                                  height: 2,
                                ),
                              )
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
