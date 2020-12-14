import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:labelize/project_theme.dart';
import 'package:link_text/link_text.dart';

class CompanyDetailScreen extends StatefulWidget {
  static const routeName = '/company-detail';
  @override
  _CompanyDetailScreenState createState() => _CompanyDetailScreenState();
}

class _CompanyDetailScreenState extends State<CompanyDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return ColorfulSafeArea(
      color: Color(0xFFF3F6F8),
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(left: 20,top: _height * .25),
          height: _height,
          width: _width,
          color: ProjectTheme.navigationBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SC-Networks GmbH',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
              ),
              buildText('Enzianstr, 2 82319 Starnmberg', _height),
              buildText('Tel: +49 8151/555 160 Fax: +49 8151/555 1629', _height),
              buildLinkText('http://www.sc-networks.com \ninfo@sc-networks.com Impressum', _height),
              buildText('Ust-IdNr: DE 813 649 228, HRB 146573', _height),
              buildText('Amstsgericht München - \nGeschäftsführer: Tobias Kuen, Martin Philipp', _height),
              Container(margin: EdgeInsets.only(top: 20,bottom: 15),height: 1,color: Colors.grey,),
              buildText('Tracking ist aktiviert: Tracking deaktivieren', _height),
              buildText('Sie sind unter folgender\nAdresse elngetragen: mustermann@sc-networks.com', _height),
              buildText('Newsletter kosternios abbestellen', _height),



            ],
          ),
        ),
      ),
    );
  }

  Widget buildText(String texthere, double _height){

    return Column(
      children: [
        SizedBox(height: _height * 0.01,),
        Text(texthere,style: TextStyle(fontSize: 14), ),
      ],
    );
  }

  Widget buildLinkText(String texthere, double _height){

    return Column(
      children: [
        SizedBox(height: _height * 0.01,),
        LinkText(text: texthere ,textStyle: TextStyle(fontSize: 14), ),
      ],
    );
  }

}
