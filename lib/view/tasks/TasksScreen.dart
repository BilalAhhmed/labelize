import 'package:circular_check_box/circular_check_box.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:labelize/model/apiModel.dart';
import 'package:labelize/project_theme.dart';
import 'package:labelize/services/singleApiDatabase.dart';
import 'package:labelize/services/constants.dart';
import 'package:labelize/widgets/CustomToast.dart';
import 'package:labelize/widgets/roundedButton.dart';
import 'package:labelize/model/allProjectsModel.dart';
import 'package:labelize/widgets/CustomToast.dart';

class TasksScreen extends StatefulWidget {
  static const routeName = '/Tasks';

  String projectId;
  int maxAnswers;
  TasksScreen({this.projectId, this.maxAnswers});

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ApiProvider apiProvider = ApiProvider();
  ApiModel data;

  AllProjectModel allProjectModel;

  int _index = 0;
  List _taskList = [];
  List<Map<String, List<String>>> selectedLabels = [];
  List<bool> checkBoxed = [];
  List<String> adder = [];

  bool selector = false;

  bool submit = false;
  bool hasData = false;

  getData() async {
    bool result =
        await apiProvider.getPackages(projectId: '${widget.projectId}');
    setState(() {
      hasData = result;
    });
    if (hasData) {
      setState(() {
        data = Constants.apiModel;
        _taskList = data.randomPackage.randomPackage.packages;
        for (int i = 0;
            i < data.randomPackage.randomPackage.packages[0].labels.length;
            i++) {
          checkBoxed.add(false);
          // adder.add('1');
        }
        print('user id ${Constants.userId}');
        print('package id: ${data.randomPackage.packageId}');
        // List<String> temp = ['1'];
        //
        // selectedLabels= List.filled(data.randomPackage.randomPackage.packages.length, temp );
      });
    } else {
      customToast(text: 'You are out of attempts');
      Navigator.pop(context);
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
        body: !hasData
            ?Align(alignment: Alignment.center,
                child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                  child: Column(
                    children: [
                      buildTopContent(_height),
                      buildContainer(_height, _width, data),
                      buildAnswers(_height, _width, data),
                      SizedBox(
                        height: _height * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomRoundedButton(
                          buttontitle: submit ? 'Submit' : 'Next text',
                          onPressed: () async {
                            setState(() {
                              List<String> temp = [];
                              adder.forEach((element) {
                                temp.add(element);
                              });
                              // selectedLabels.add(temp);
                              Map<String, List<String>> tempMap = {
                                'labels': temp
                              };
                              print(checkBoxed);
                              if (checkBoxed.contains(true)) {
                                selectedLabels.add(tempMap);
                              }
                              print(_index);
                              print(selectedLabels);
                            });
                            if (checkBoxed.contains(true)) {
                              if (_index < _taskList.length - 1) {
                                setState(() {
                                  _index++;

                                  checkBoxed.clear();

                                  for (int i = 0;
                                      i <
                                          data.randomPackage.randomPackage
                                              .packages[_index].labels.length;
                                      i++) {
                                    checkBoxed.insert(i, false);
                                  }
                                  adder.clear();

                                  if (_index == _taskList.length - 1)
                                    submit = !submit;
                                });
                              } else if (submit) {
                                print(data.randomPackage.packageId);
                                // print('Your paper is submitted');
                                bool result = await apiProvider.createPost(
                                    labels: selectedLabels,
                                    package_id: data.randomPackage.packageId,
                                    time_taken: '11:11');
                                if (result) {
                                  customToast(
                                      text: 'Your task has been submitted');
                                  Navigator.pop(context);
                                } else {
                                  customToast(
                                      text: 'Your task is failed to submit');
                                  Navigator.pop(context);
                                }
                              }
                            } else {
                              customToast(
                                  text: 'Please select any option/options');
                            }
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
            'Task\n${_index + 1}/${_taskList.length}'.toUpperCase(),
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

  Widget buildContainer(double _height, double _width, ApiModel data) {
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
          child: buildCenterContent(_height, _width, data),
        ),
        SizedBox(
          height: _height * 0.04,
        )
      ],
    );
  }

  Widget buildCenterContent(double _height, double _width, ApiModel data) {
    return ListView(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                  '${data.randomPackage.randomPackage.packages[_index].header}',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
            ),
            SizedBox(
              height: _height * 0.04,
            ),
            Text('${data.randomPackage.randomPackage.packages[_index].text}')
          ],
        ),
      ],
    );
  }

  Widget buildAnswers(double _height, double _width, ApiModel data) {
    return Form(
      key: _formKey,
      child: Container(
          height: _height * 0.35,
          child: ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: data
                  .randomPackage.randomPackage.packages[_index].labels.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return buildAnswersContainer(_height,
                    '${data.randomPackage.randomPackage.packages[_index].labels[index]}',
                    value: checkBoxed[index], index: index);
              })),
    );
  }

  Widget buildAnswersContainer(double _height, String _title,
      {bool value, int index}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
          child: Container(
            padding: EdgeInsets.only(left: 10),
            width: double.infinity,
            height: _height * 0.06,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 0), spreadRadius: 1),
              ],
            ),
            child: InkWell(
              onTap: () {
                setState(() {
                  if (checkBoxed[index] == false) {
                    checkBoxed[index] = true;
                  } else {
                    checkBoxed[index] = false;
                  }
                });
                setState(() {
                  if (checkBoxed.elementAt(index) == true) {
                    adder.add(_title);
                  } else {
                    if (adder.contains(_title)) {
                      adder.remove(_title);
                    }
                  }
                  //print(adder);
                  // selected = newValue;
                });
              },
              child: Row(
                children: [
                  CircularCheckBox(
                      checkColor: Colors.black,
                      activeColor: Colors.transparent,
                      value: value, //selected,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onChanged: (bool newValue) {
                        setState(() {
                          checkBoxed.removeAt(index);
                          checkBoxed.insert(index, newValue);
                          if (checkBoxed.elementAt(index) == true) {
                            adder.add(_title);
                          } else {
                            if (adder.contains(_title)) {
                              adder.remove(_title);
                            }
                          }
                          //print(adder);
                          // selected = newValue;
                        });
                      }),
                  SizedBox(width: 15),
                  Text(
                    _title,
                    style: TextStyle(fontSize: 17),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: _height * 0.025,
        )
      ],
    );
  }
}
