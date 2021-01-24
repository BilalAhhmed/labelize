import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:labelize/view/bottomNavigationBarScreens/BottomNavigationBar.dart';
import 'package:labelize/view/tasks/TasksScreen.dart';
import 'package:labelize/widgets/roundedButton.dart';
import 'package:labelize/services/allProjectDatabase.dart';
import 'package:labelize/model/allProjectsModel.dart';
import 'package:labelize/services/constants.dart';
import 'package:labelize/widgets/CustomToast.dart';
import 'package:labelize/view/tasks/TasksScreen.dart';

import '../../project_theme.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AllProjectsApiProvider allProjectsApiProvider = AllProjectsApiProvider();
  AllProjectModel data;
  int _index = 0;
  List _taskList = [];

  bool submit = false;
  bool hasData = false;

  SwiperController _scrollController;

  getData() async {
    bool result = await allProjectsApiProvider.getPackages();
    if (mounted) {
      setState(() {
        hasData = result;
      });
    }
    if (hasData) {
      if (mounted) {
        setState(() {
          data = Constants.allProjectModel;
          _taskList = data.data.projects;
        });
      }
    } else {
      if (mounted) {
        customToast(text: 'There are no package at the moment.');
        // Navigator.pop(context);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return ColorfulSafeArea(
      color: ProjectTheme.projectBackgroundColor,
      child: Scaffold(
        body:
        // !hasData
        //     ? Align(alignment: Alignment.center,
        //         child: CircularProgressIndicator())
        //     :
        Container(
                height: _height,
                color: ProjectTheme.navigationBackgroundColor,
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildTopText(_height, _width, data),
                        buildContainer(_height, _width, data),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget buildTopText(double _height, double width, AllProjectModel data) {
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
          child: Text(!hasData? '0\nCREDITS' :
            '${data.data.projects[_index].creditsPerPackage}\nCREDITS'.toUpperCase(),
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

  Widget buildContainer(double _height, double _width, AllProjectModel data) {
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
      child: !hasData? Center(child: Text('Coming Soon...',style: TextStyle(fontSize: 20),),) : buildCenterContent(_height, _width, data),
    );
  }

  Widget buildCenterContent(
      double _height, double _width, AllProjectModel data) {
    TextStyle style = TextStyle(fontSize: 15, letterSpacing: 1);
    return Swiper(
      onIndexChanged: (int index){
        setState(() {
          _index = index;
        });
      },
      index: _index,
      controller: _scrollController,
      // loop: false,
      itemCount: _taskList.length,

      itemBuilder: (BuildContext context, int index) {print(_index);
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
              Text(      '${data.data.projects[index].description}', style: style),
              SizedBox(
                height: _height * 0.05,
              ),
             CustomRoundedButton(
                buttontitle: 'Fetch the Task',
                onPressed: () {

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => TasksScreen(
                                projectId: data.data.projects[index].projectId,
                            maxAnswers: int.parse(data.data.projects[index].maxAnswersPerPackage,)

                              )));
                  //  Navigator.pushNamed(context, TasksScreen.routeName);
                },
              )
            ],
          ),
        );
      },
    );
  }
}
