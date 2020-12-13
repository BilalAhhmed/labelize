import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:labelize/project_theme.dart';
import 'package:labelize/view/tasks/TaskScreen2.dart';
import 'package:labelize/widgets/roundedButton.dart';

class TasksScreen extends StatefulWidget {
  static const routeName = '/Tasks';
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return ColorfulSafeArea(
      color: ProjectTheme.projectBackgroundColor,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
              child: Column(
                children: [
                  buildTopContent(_height),
                  buildContainer(_height, _width),
                  buildAnswers(_height, _width),
                  SizedBox(height: _height * 0.02,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomRoundedButton(buttontitle: 'Next text',onPressed: (){
                      Navigator.pushNamed(context, TaskScreen2.routeName);
                    },),
                  )
                ],
              )),
        ),
      ),
    );
  }

  Widget buildTopContent(double _height) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
              icon: ImageIcon(
                AssetImage(
                  'assets/cancel.png',
                ),
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            'Task\n1/2'.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              letterSpacing: 1,
              fontSize: 16,
            ),
          ),
        ),
        SizedBox(
          height: _height * 0.09,
        )
      ],
    );
  }

  Widget buildContainer(double _height, double _width) {
    return Column(
      children: [
        Container(
          height: _height * 0.35,
          width: _width,
          padding: EdgeInsets.only(top: 35, left: 15, right: 15),
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
        ),
        SizedBox(height: _height * 0.04,)
      ],
    );
  }

  Widget buildCenterContent(double _height, double _width) {
    TextStyle style = TextStyle(
      fontSize: 17,
    );
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Text('What is this text about?',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18))),
          SizedBox(
            height: _height * 0.04,
          ),
          Text(
              'A US teenage TikTok user’s attempt to spread awareness about China’s oppression of its Uighur Muslim population has renewed questions about censorship on the China-based social media company’s platform.',
              style: style),
        ],
      ),
    );
  }





  Widget buildAnswers(double _height, double _width) {
    return Container(
      height: _height * 0.35,

      child: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          buildAnswersContainer(_height, 'Politics'),
          buildAnswersContainer(_height, 'Sports'),
          buildAnswersContainer(_height, 'Entertainment'),
          buildAnswersContainer(_height,'Technology'),



        ],
      ),
    );
  }
  Widget buildAnswersContainer(double _height, String _title){
    bool _value = false;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5,right: 5,top: 5),
          child: Container(
            padding: EdgeInsets.only(left: 10),
            width: double.infinity,
            height: _height * 0.06,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black,
                    offset: Offset(0, 0),
                    spreadRadius: 1),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.radio_button_off),
                SizedBox(width: 15),
                Text(_title,style: TextStyle(fontSize: 17),)
              ],
            ),
          ),
        ),
        SizedBox(height: _height *0.025,)
      ],
    );
  }
}
