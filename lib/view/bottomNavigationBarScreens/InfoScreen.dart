import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:labelize/view/bottomNavigationBarScreens/companyDetailScreen.dart';

import '../../project_theme.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    TextStyle style = TextStyle(fontSize: 40, fontWeight: FontWeight.w300);
    TextStyle listStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.w400);
    return ColorfulSafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(

            padding: const EdgeInsets.all(30),
            color: ProjectTheme.navigationBackgroundColor,
            height: _height,
            child: ListView(
              children: [
                Text('How to', style: style),
                // SizedBox(height: _height *0.02,),
                ListTile(
                  contentPadding: EdgeInsets.only(top: 20, left: 20),
                  isThreeLine: true,
                  title: Text(
                    'Step 1',
                    style: listStyle,
                  ),
                  subtitle: Text('Steps to be entered here'),
                ),
                ListTile(
                  isThreeLine: true,
                  title: Text(
                    'Step 2',
                    style: listStyle,
                  ),
                  subtitle: Text('Steps to be entered here'),
                ),
                ListTile(
                  isThreeLine: true,
                  title: Text(
                    'Step 3',
                    style: listStyle,
                  ),
                  subtitle: Text('Steps to be entered here'),
                ),
                SizedBox(height: _height * 0.3),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    child: Text(
                      'Imprint'.toUpperCase(),
                      style:
                          style.copyWith(decoration: TextDecoration.underline),
                    ),
                    onTap: (){
                      Navigator.pushNamed(context, CompanyDetailScreen.routeName);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
