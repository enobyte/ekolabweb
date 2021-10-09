import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AboutState();
  }
}

class AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          txt: "Tentang",
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: TextWidget(
          txt:
              "Situs e-kolab bertujuan untuk memfasilitasi Waralaba, Konsinyasi, Kerja sama, Jejaring Organisasi dan penawaran legalitas UMKM",
        ),
      ),
    );
  }
}
