import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material and Cupertino Controls',
      theme: ThemeData(
        primarySwatch: Colors.green,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.blue,
            textStyle: TextStyle(fontSize: 16),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  void _showMaterialAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Material Alert'),
          content: Text('This is a Material alert.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showCupertinoActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Title'),
        message: const Text('Message'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Default Action'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Action'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Destructive Action'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material and Cupertino Controls'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SegmentedControlExample(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _showMaterialAlert(context),
                child: Text('Show Material Alert'),
              ),
              SizedBox(height: 20),
              CupertinoSliderExample(),
              SizedBox(height: 20),
              CupertinoButton(
                onPressed: () => _showCupertinoActionSheet(context),
                child: Text('Show Cupertino Action Sheet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CupertinoSliderExample extends StatefulWidget {
  const CupertinoSliderExample({super.key});

  @override
  State<CupertinoSliderExample> createState() => _CupertinoSliderExampleState();
}

class _CupertinoSliderExampleState extends State<CupertinoSliderExample> {
  double _currentSliderValue = 0.0;
  String? _sliderStatus;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('Slider Value: $_currentSliderValue'),
        CupertinoSlider(
          key: const Key('slider'),
          value: _currentSliderValue,
          divisions: 5,
          max: 100,
          activeColor: CupertinoColors.systemPurple,
          thumbColor: CupertinoColors.systemPurple,
          onChangeStart: (double value) {
            setState(() {
              _sliderStatus = 'Sliding';
            });
          },
          onChangeEnd: (double value) {
            setState(() {
              _sliderStatus = 'Finished sliding';
            });
          },
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value;
            });
          },
        ),
        Text(
          _sliderStatus ?? '',
          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                fontSize: 12,
              ),
        ),
      ],
    );
  }
}

enum Sky { midnight, viridian, cerulean }

Map<Sky, Color> skyColors = <Sky, Color>{
  Sky.midnight: const Color(0xff191970),
  Sky.viridian: const Color(0xff40826d),
  Sky.cerulean: const Color(0xff007ba7),
};

class SegmentedControlExample extends StatefulWidget {
  const SegmentedControlExample({super.key});

  @override
  State<SegmentedControlExample> createState() =>
      _SegmentedControlExampleState();
}

class _SegmentedControlExampleState extends State<SegmentedControlExample> {
  Sky _selectedSegment = Sky.midnight;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: skyColors[_selectedSegment],
      navigationBar: CupertinoNavigationBar(
        middle: CupertinoSegmentedControl<Sky>(
          selectedColor: skyColors[_selectedSegment],
          padding: const EdgeInsets.symmetric(horizontal: 12),
          groupValue: _selectedSegment,
          onValueChanged: (Sky value) {
            setState(() {
              _selectedSegment = value;
            });
          },
          children: const <Sky, Widget>{
            Sky.midnight: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Text('Midnight', style: TextStyle(fontSize: 18)),
            ),
            Sky.viridian: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Text('Viridian', style: TextStyle(fontSize: 18)),
            ),
            Sky.cerulean: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Text('Cerulean', style: TextStyle(fontSize: 18)),
            ),
          },
        ),
      ),
      child: Center(
        child: Text(
          'Selected Segment: ${_selectedSegment.name}',
          style: const TextStyle(color: CupertinoColors.white, fontSize: 18),
        ),
      ),
    );
  }
}
