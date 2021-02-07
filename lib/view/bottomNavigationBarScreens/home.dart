import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:labelize/view/bottomNavigationBarScreens/BottomNavigationBar.dart';
import 'package:labelize/view/tasks/TasksScreen.dart';
import 'package:labelize/widgets/customCircularLoader.dart';
import 'package:labelize/widgets/roundedButton.dart';
import 'package:labelize/services/allProjectDatabase.dart';
import 'package:labelize/model/allProjectsModel.dart';
import 'package:labelize/services/constants.dart';
import 'package:labelize/widgets/CustomToast.dart';
import 'package:labelize/view/tasks/TasksScreen.dart';
import 'package:labelize/services/database.dart';
import 'package:labelize/model/userModel.dart';

import '../../project_theme.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final CollectionReference maxAllowedUsers =
  FirebaseFirestore.instance.collection('website');

  AllProjectsApiProvider allProjectsApiProvider = AllProjectsApiProvider();
  AllProjectModel data;
  int _index = 0;
  List _taskList = [];
  DatabaseService database = DatabaseService(uId: Constants.userId);

  bool submit = false;
  bool hasData = false;
  String imgExtension;

  SwiperController _scrollController;


  String maxCreditsAllowedPerUser;

  getMaxUsers() async {
    await FirebaseFirestore.instance.collection('config').doc('website')
        .get()
        .then((snapshot) {
      setState(() {
        maxCreditsAllowedPerUser =
            snapshot.data()['maxCreditsAllowedPerUser'].toString();
      });
      print(maxCreditsAllowedPerUser);
    });
  }


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

  FirebaseStorage storage = FirebaseStorage.instance;

  //
  //

  @override
  void initState() {
    super.initState();
    getData();
    getMaxUsers();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery
        .of(context)
        .size
        .height;
    var _width = MediaQuery
        .of(context)
        .size
        .width;
    return ColorfulSafeArea(
      color: ProjectTheme.projectBackgroundColor,
      child: Scaffold(
          body: StreamBuilder(
              stream: database.userStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                List<UserModel> use = snapshot.data;
                int index = 0;
                for (int i = 0; i < use.length; i++) {
                  if (Constants.user.email == use[i].email) {
                    index = i;
                    break;
                  }
                }
                UserModel credit = snapshot.data[index];

                return Container(
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
                          buildTopText(_height, _width, data, credit),
                          buildContainer(_height, _width, data, credit),
                        ],
                      ),
                    ),
                  ),
                );
              })),
    );
  }

  Widget buildTopText(double _height, double width, AllProjectModel data,
      UserModel credit) {
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
            '${credit.credits}\nCREDITS'.toUpperCase(),
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

  Widget buildContainer(double _height, double _width, AllProjectModel data,
      UserModel credit) {
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
      child: !hasData
          ? Center(
        child: Text(
          'Coming Soon...',
          style: TextStyle(fontSize: 20),
        ),
      )
          : buildCenterContent(_height, _width, data, credit),
    );
  }

  Widget buildCenterContent(double _height, double _width, AllProjectModel data,
      UserModel credit) {
    TextStyle style = TextStyle(fontSize: 15, letterSpacing: 1);
    // String imgExtension = data.data.projects[_index].imgFile.split('.').last;
    imgExtension = data.data.projects[_index].imgFile
        .split('.')
        .last;

    Future<String> downoadUrl() async {
      Reference ref = storage
          .ref()
          .child('projects')
          .child('${data.data.projects[_index].projectId}')
          .child('project_image.$imgExtension');
      String url = await ref.getDownloadURL();
      // print(data.data.projects[_index].projectId);

      return url;
    }


    return Swiper(
      onIndexChanged: (int index) {



        setState(() {
          _index = index;
          imgExtension = data.data.projects[index].imgFile
              .split('.')
              .last;
        });
      },
      index: _index,
      controller: _scrollController,
      // loop: false,
      itemCount: _taskList.length,

      itemBuilder: (BuildContext context, int index) {
        // print(url);


        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              !hasData
                  ? '0\nCREDITS'
                  : Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'CREDITS: ${data.data.projects[_index].creditsPerPackage}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      letterSpacing: 1,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
              SizedBox(height: 5,),
              FutureBuilder(
                future: downoadUrl(),
                builder: (context, snapshot) {
                  var data = snapshot.data;
                  if (snapshot.data == null) {
                    return Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    );
                  }
                  else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Image(
                        image: NetworkImage('$data'),
                        fit: BoxFit.contain,
                      ),
                    );
                  }
                },
              ),
              SizedBox(
                height: _height * 0.03,
              ),
              Text('${data.data.projects[index].name}'.toUpperCase(),
                  style: style),
              SizedBox(
                height: _height * 0.045,
              ),
              Text('${data.data.projects[index].description}', style: style),
              SizedBox(
                height: _height * 0.05,
              ),

              CustomRoundedButton(
                buttontitle: 'Fetch the Task',
                onPressed: () {
                  int max = int.parse(maxCreditsAllowedPerUser);
                  if (credit.credits < max) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                TasksScreen(
                                    projectId: data.data.projects[index]
                                        .projectId,
                                    maxAnswers: int.parse(
                                      data.data.projects[index]
                                          .maxAnswersPerPackage,
                                    ))));
                  }
                  else {
                    customToast(
                        text: "User have achieved it's max Credits limit");
                  }


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
