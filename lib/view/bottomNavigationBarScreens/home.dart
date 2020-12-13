import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:labelize/view/bottomNavigationBarScreens/BottomNavigationBar.dart';
import 'package:labelize/view/tasks/TasksScreen.dart';
import 'package:labelize/widgets/roundedButton.dart';

import '../../project_theme.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return ColorfulSafeArea(
      color: ProjectTheme.projectBackgroundColor,
      child: Scaffold(
        body: Container(
          height: _height,
          color: Color(0xFFF3F6F8),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTopText(_height, _width),
                  buildContainer(_height, _width),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTopText(double _height , double width) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            'Home'.toUpperCase(),
            style: TextStyle(
              letterSpacing: 1,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Text(
            '500\nCREDITS'.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              letterSpacing: 1,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(
          height: _height * 0.14,
        )
      ],
    );
  }

  Widget buildContainer(double _height, double _width) {
    return Container(
      height: _height * 0.6,
      width: _width,
      padding: EdgeInsets.only(top: 15, left: 30, right: 30),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 50,
            offset: Offset(0, 25), // changes position of shadow
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: buildCenterContent(_height, _width),
    );
  }

  Widget buildCenterContent(double _height, double _width) {
    TextStyle style = TextStyle(fontSize: 15, letterSpacing: 1);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Image(
              image: AssetImage('assets/image.png'),
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: _height * 0.03,
          ),
          Text('Your Next Project!'.toUpperCase(), style: style),
          SizedBox(
            height: _height * 0.045,
          ),
          Text(
              'Do The Following Task From This Project And Receive Xxx Amount (Pre-Set In Admin Panel) Of Credits!',
              style: style),
          SizedBox(
            height: _height * 0.13,
          ),
          CustomRoundedButton(buttontitle: 'Fetch the Task', onPressed: (){
            Navigator.pushNamed(context, TasksScreen.routeName);
          },)
        ],
      ),
    );
  }
}

