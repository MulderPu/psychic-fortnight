import 'package:flutter/material.dart';
import 'package:genshin_calculator/utils/colors.dart';
import 'package:genshin_calculator/utils/constant.dart';
import 'package:genshin_calculator/utils/keys.dart';
import 'package:genshin_calculator/views/widgets/gradientAppBar.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class ResinTimeView extends StatefulWidget {
  const ResinTimeView({Key? key}) : super(key: key);

  @override
  _ResinTimeViewState createState() => _ResinTimeViewState();
}

class _ResinTimeViewState extends State<ResinTimeView> {
  TextEditingController yourResinController = TextEditingController();
  TextEditingController resinNeededController = TextEditingController();
  String? result;
  String? expectedTime;
  final regenerateTime = 8; // mins

  // Create a global key that uniquely identifies the Form widget
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    result = "--";
    expectedTime = "--";
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppBar(
        title: "Resin Time",
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: TextFormField(
                      key: const Key(ResinTimePageKeys.RESIN_FIELD),
                      controller: yourResinController,
                      cursorColor: Colors.purple,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Your Resin:',
                          labelStyle: TextStyle(
                              color: Colors.grey, fontSize: FONT_LABEL.sp),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.purple, width: 2.0),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          hintText: ''),
                      validator: (value) {
                        if (value == "") {
                          return 'Resin field cannot be empty.';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: TextFormField(
                      key: const Key(ResinTimePageKeys.RESIN_NEEDED_FIELD),
                      controller: resinNeededController,
                      cursorColor: Colors.purple,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Resin Needed:',
                          labelStyle: TextStyle(
                              color: Colors.grey, fontSize: FONT_LABEL.sp),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.purple, width: 2.0),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          hintText: ''),
                      validator: (value) {
                        if (value == "") {
                          return 'Resin needed field cannot be empty.';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          key: const Key(ResinTimePageKeys.CALCULATE_BUTTON),
                          style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(fontSize: FONT_BUTTON.sp),
                            onPrimary: Colors.white,
                            primary: lightPurple,
                            onSurface: Colors.grey,
                            minimumSize: const Size(double.infinity, 50),
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          onPressed: () {
                            // dismiss keyboard
                            FocusScope.of(context).unfocus();

                            if (_formKey.currentState!.validate()) {
                              int neededResin =
                                  int.parse(resinNeededController.text);
                              int currentResin =
                                  int.parse(yourResinController.text);
                              var remainResin = neededResin - currentResin;
                              var totalMinutes = (remainResin * regenerateTime);
                              var convertHourMins = totalMinutes / 60;
                              var hours = convertHourMins.toInt();
                              var mins =
                                  (convertHourMins - hours.toDouble()) * 60;

                              setState(() {
                                result =
                                    "$hours hours and ${mins.round()} mins";
                                resinNeededController.text =
                                    neededResin.toString();
                                yourResinController.text =
                                    currentResin.toString();

                                var now = DateTime.now();
                                var expectDatetime = now.add(Duration(
                                    hours: hours, minutes: mins.toInt()));

                                expectedTime = DateFormat('yyyy-MM-dd – kk:mm')
                                    .format(expectDatetime);
                              });
                            }
                          },
                          child: const Text('Calculate')),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Result: $result',
                      style: TextStyle(fontSize: FONT_BODY.sp),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Expected DateTime: $expectedTime',
                      style: TextStyle(fontSize: FONT_BODY.sp),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
