import 'dart:async';

import 'package:fit_kit/fit_kit.dart';
import 'package:flutter/material.dart';

class StepsScreen extends StatefulWidget {
  @override
  _StepsScreenState createState() => _StepsScreenState();
}

class _StepsScreenState extends State<StepsScreen> {
  int _steps = 4;
  int _totalSteps = 0;

  @override
  Widget build(BuildContext context) {
    void addSteps(results) {
      results.forEach((result) => {_totalSteps = _totalSteps += result.value});

      setState(() {
        _totalSteps = _totalSteps;
      });
    }

    void clearSteps() {
      setState(() {
        _totalSteps = 0;
      });
    }

    void read() async {
      final results = await FitKit.read(
        DataType.STEP_COUNT,
        dateFrom: DateTime.now().subtract(Duration(days: 1)),
        dateTo: DateTime.now(),
      );
      // print(results);
      clearSteps();
      addSteps(results);
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Steps counter"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Steps from today",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text('$_totalSteps Steps',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            RaisedButton(
              onPressed: () => read(),
              child: const Text('Read steps', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
