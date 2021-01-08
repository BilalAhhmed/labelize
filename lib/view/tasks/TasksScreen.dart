import 'package:circular_check_box/circular_check_box.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:labelize/model/apiModel.dart';
import 'package:labelize/project_theme.dart';
import 'package:labelize/services/singleApiDatabase.dart';
import 'package:labelize/services/constants.dart';
import 'package:labelize/view/tasks/TaskScreen2.dart';
import 'package:labelize/widgets/CustomToast.dart';
import 'package:labelize/widgets/roundedButton.dart';
import 'package:labelize/model/allProjectsModel.dart';

class TasksScreen extends StatefulWidget {
  static const routeName = '/Tasks';

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  ApiProvider apiProvider = ApiProvider();
  ApiModel data;

  AllProjectModel allProjectModel;

  int _index = 0;
  List _taskList = [];
  List<List<String>> selectedLabels = List();
  List<bool> checkBoxed = List();
  List<String> adder = List();

  bool selected = false;

  bool submit = false;
  bool hasData = false;

  getData() async {
    bool result =
        await apiProvider.getPackages(projectId: 'hiL9a9RuYKNuWchwoLro');
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
        }
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
            ? Padding(
                padding: EdgeInsets.only(
                    top: _height * 0.4, left: _width * 0.41, right: 20),
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
                          onPressed: () {
                            setState(() {
                              if (_index < _taskList.length - 1) {
                                _index++;

                                selectedLabels.add(adder);

                                // apiProvider.createPost(
                                //     labels: selectedLabels,
                                //     package_id: data.randomPackage.packageId,
                                //     time_taken: '1');
                                for (int i = 0;
                                    i <
                                        data.randomPackage.randomPackage
                                            .packages[_index].labels.length;
                                    i++) {
                                  checkBoxed.add(false);
                                }
                                adder.clear();
                                print(selectedLabels);
                                if (_index == _taskList.length - 1)
                                  submit = !submit;
                              } else if (submit) {
                                print('Your paper is submitted');
                                //Navigator
                              }
                              //return Text(' Tasks Completed');
                            });
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
    return Container(
        height: _height * 0.35,
        child: ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount:
                data.randomPackage.randomPackage.packages[_index].labels.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return buildAnswersContainer(_height,
                  '${data.randomPackage.randomPackage.packages[_index].labels[index]}',
                  value: checkBoxed[index], index: index);
            }));
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
            child: Row(
              children: [
                CircularCheckBox(
                    checkColor: Colors.black,
                    activeColor: Colors.transparent,
                    value: value, //selected,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    onChanged: (bool newValue) {
                      setState(() {
                        checkBoxed.removeAt(index);
                        checkBoxed.insert(index, newValue);
                        if (checkBoxed.elementAt(index) == true) {
                          adder.insert(index, _title);
                        } else {
                          adder.removeAt(index);
                        }

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
        SizedBox(
          height: _height * 0.025,
        )
      ],
    );
  }
}
