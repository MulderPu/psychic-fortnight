import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ResinTimeView extends StatefulWidget {
  ResinTimeView({Key key}) : super(key: key);

  @override
  _ResinTimeViewState createState() => _ResinTimeViewState();
}

class _ResinTimeViewState extends State<ResinTimeView> {
  TextEditingController yourResinController = TextEditingController();
  TextEditingController resinNeededController = TextEditingController();
  var result;
  var expectedTime;
  final regenerateTime = 8; // mins

  @override
  void initState() {
    super.initState();

    result = "--";
    expectedTime = "--";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resin Time"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: yourResinController,
                decoration: InputDecoration(
                    labelText: 'Your Resin:',
                    border: InputBorder.none,
                    hintText: ''),
              ),
              TextField(
                controller: resinNeededController,
                decoration: InputDecoration(
                    labelText: 'Resin Needed:',
                    border: InputBorder.none,
                    hintText: ''),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.white,
                      primary: Colors.purple,
                      onSurface: Colors.grey,
                      minimumSize: Size(double.infinity, 50),
                      elevation: 10,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () {
                      // dismiss keyboard
                      FocusScope.of(context).unfocus();

                      int neededResin = int.parse(resinNeededController.text);
                      int currentResin = int.parse(yourResinController.text);
                      var remainResin = neededResin - currentResin;
                      var totalMinutes = (remainResin * regenerateTime);
                      var convertHourMins = totalMinutes / 60;
                      var hours = convertHourMins.toInt();
                      var mins = (convertHourMins - hours.toDouble()) * 60;
                      
                      setState(() {
                        result = "$hours hours and ${mins.round()} mins";
                        resinNeededController.text = neededResin.toString();
                        yourResinController.text = currentResin.toString();

                        var now = DateTime.now();
                        var expectDatetime = now
                            .add(Duration(hours: hours, minutes: mins.toInt()));

                        expectedTime = DateFormat('yyyy-MM-dd – kk:mm')
                            .format(expectDatetime);
                      });
                    },
                    child: Text('Calculate')),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Result: $result',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Expected DateTime: $expectedTime',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
