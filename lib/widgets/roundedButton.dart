import 'package:flutter/material.dart';
import 'package:labelize/project_theme.dart';

class CustomRoundedButton extends StatelessWidget {
  String buttontitle;
  var onPressed;
  CustomRoundedButton({@required this.buttontitle,  @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;

    return Container(
      width: _width,
      decoration: BoxDecoration(
          color: ProjectTheme.projectPrimaryColor,
          borderRadius: BorderRadius.all(Radius.circular(30))
      ),

      child: FlatButton(
        onPressed: onPressed,
        child: Text(buttontitle,style: TextStyle(color: Colors.white,fontSize: 16    ),),
      ),
    );
  }
}
