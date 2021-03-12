import 'package:flutter/material.dart';

class ResinTimeView extends StatefulWidget {
  ResinTimeView({Key key}) : super(key: key);

  @override
  _ResinTimeViewState createState() => _ResinTimeViewState();
}

class _ResinTimeViewState extends State<ResinTimeView> {
  TextEditingController yourResinController = TextEditingController();
  TextEditingController resinNeededController = TextEditingController();
  var result;
  final regenerateTime = 8; // mins

  @override
  void initState() {
    super.initState();

    result = "--";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resin Time"),
      ),
      body: Center(
        child: SizedBox(
          width: 500,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: yourResinController,
                  style: Theme.of(context).textTheme.headline4,
                  decoration: InputDecoration(
                      labelText: 'Your Resin:',
                      labelStyle: Theme.of(context).textTheme.headline5,
                      border: InputBorder.none,
                      hintText: ''),
                ),
                TextField(
                  controller: resinNeededController,
                  style: Theme.of(context).textTheme.headline4,
                  decoration: InputDecoration(
                      labelText: 'Resin Needed:',
                      labelStyle: Theme.of(context).textTheme.headline5,
                      border: InputBorder.none,
                      hintText: ''),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          padding:
                              MaterialStateProperty.all(EdgeInsets.all(20)),
                          textStyle: MaterialStateProperty.all(
                              TextStyle(fontSize: 20))),
                      onPressed: () {
                        print('calculate');
                        print('Your resin: ${yourResinController.text}');
                        print('Resin Needed: ${resinNeededController.text}');
                        int neededResin = int.parse(resinNeededController.text);
                        int currentResin = int.parse(yourResinController.text);
                        var remainResin = neededResin - currentResin;
                        print('Remaining Resin: $remainResin');
                        var totalMinutes = (remainResin * regenerateTime);
                        print('Total Time: $totalMinutes');
                        var convertHourMins = totalMinutes / 60;
                        print('Result: $convertHourMins');
                        var hours = convertHourMins.toInt();
                        print('Hours: $hours');
                        var mins = (convertHourMins - hours.toDouble()) * 60;
                        print('Mins: ${mins.round()}');
                        setState(() {
                          result = "$hours hours and ${mins.round()} mins";
                          resinNeededController.text = neededResin.toString();
                          yourResinController.text = currentResin.toString();
                        });
                      },
                      child: Text('Calculate')),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Result: $result',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                // Text(
                //   '$_counter',
                //   style: Theme.of(context).textTheme.headline4,
                // ),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
