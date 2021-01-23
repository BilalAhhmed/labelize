import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:labelize/project_theme.dart';
import 'package:customtogglebuttons/customtogglebuttons.dart';
import 'package:labelize/services/paymentApi.dart';
import 'package:labelize/widgets/CustomToast.dart';
import 'package:labelize/widgets/roundedButton.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  PaymentApiProvider paymentApiProvider = PaymentApiProvider();
  String paymenMethod = '';

  List<bool> _isSelected = [false, false];
  bool isLoggingIn = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _creditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return ColorfulSafeArea(
        color: ProjectTheme.projectBackgroundColor,
        child: Scaffold(
          body: Container(
            color: ProjectTheme.navigationBackgroundColor,
            height: _height,
            child: ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTopContent(_height),
                    Divider(
                      color: Colors.grey.withOpacity(0.3),
                      thickness: 1,
                    ),
                    buildPaymentMethod(_height, _width),
                    buildForm(_height),
                    buildButton()
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Widget buildTopContent(double _height) {
    TextStyle style = TextStyle(letterSpacing: 1, fontSize: 16);
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              'Rewards'.toUpperCase(),
              style: style,
            ),
          ),
          SizedBox(
            height: _height * 0.05,
          ),
          Text(
            'Balance:\n500 Credits',
            textAlign: TextAlign.center,
            style: style,
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Widget buildPaymentMethod(double _height, double _width) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose your Pay-out method',
            style: TextStyle(letterSpacing: 1, fontSize: 16),
          ),
          SizedBox(
            height: _height * 0.015,
          ),
          Container(
            child: CustomToggleButtons(
              borderWidth: 0,
              renderBorder: false,
              borderColor: Colors.transparent,
              spacing: _width * 0,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: ProjectTheme.projectBackgroundColor,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  height: _height * 0.075,
                  width: _width * 0.365,
                  child: ImageIcon(
                      AssetImage(
                        'assets/paypal.png',
                      ),
                      size: 35),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: ProjectTheme.projectBackgroundColor,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  height: _height * 0.075,
                  width: _width * 0.365,
                  child: ImageIcon(
                      AssetImage(
                        'assets/amazon.png',
                      ),
                      size: 35),
                ),
              ],
              isSelected: _isSelected,
              onPressed: (int index) {
                setState(() {
                  for (int indexBtn = 0;
                      indexBtn < _isSelected.length;
                      indexBtn++) {
                    if (indexBtn == index) {
                      _isSelected[indexBtn] = !_isSelected[indexBtn];
                    } else {
                      _isSelected[indexBtn] = false;
                    }
                  }
                  if(_isSelected[0] == true) {
                      setState(() {
                          paymenMethod = 'Paypal';
                      });
                  }
                  else if (_isSelected[1] == true){
                      setState(() {
                          paymenMethod = 'amazon';
                      });
                  }
                  else {
                      setState(() {
                        paymenMethod = '';
                      });
                  }
                  print(paymenMethod);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildForm(double _height) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select the amount of credits',
              style: TextStyle(letterSpacing: 1, fontSize: 16),
            ),
            SizedBox(
              height: _height * 0.01,
            ),
            TextFormField(
                controller: _creditController,
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty) return '';
                  return null;
                },
                decoration: kInputDecoration),
            SizedBox(
              height: _height * 0.03,
            ),
            Text(
              'Enter your E-mail address',
              style: TextStyle(letterSpacing: 1, fontSize: 16),
            ),
            SizedBox(
              height: _height * 0.01,
            ),
            TextFormField(
                controller: _emailController,
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty) return '';
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'E-mail address',
                    hintStyle: TextStyle(color: Colors.grey, letterSpacing: 1, fontSize: 15),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFF4DD942)),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(20),
                        ),
                    ),
                )),
            SizedBox(
              height: _height * 0.18,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton() {
      // dynamic amount = int.parse(_creditController.text);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: CustomRoundedButton(
        buttontitle: 'Request pay-out',
        onPressed: () async{
            if(paymenMethod != '') {
                if(int.parse(_creditController.text) >= 500){
                    if (_formKey.currentState.validate()) {
                    bool result = await paymentApiProvider.createPost(
                        amount: int.parse(_creditController.text),
                        email: _emailController.text,
                        payment_type: paymenMethod);
                    if (result) {
                        customToast(
                            text: 'Redeem request sent');
                    } else {
                        customToast(
                            text: 'Redeem request failed');
                    }
                }

                }
                else{
                    customToast(text: 'Please Type amount greater than or equal to 500');

                }

            }
            else {
                customToast(text: 'Please Select any Payment method');
            }

            setState(() {
                _creditController.clear();
                _emailController.clear();
                _isSelected = [false, false];
            });
        },
      ),
    );
  }

  static const kInputDecoration = InputDecoration(
    hintText: 'Enter amount here (minimum 500 credits)',
    hintStyle: TextStyle(color: Colors.grey, letterSpacing: 1, fontSize: 15),
    filled: true,
    fillColor: Colors.white,
    focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF4DD942)),
        borderRadius: BorderRadius.all(Radius.circular(20))),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
    ),
  );
}
