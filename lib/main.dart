import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class _InheritedCounter extends InheritedWidget {
  const _InheritedCounter({
    required this.data,
    required super.child,
  });

  final MyCounterState data;

  @override
  bool updateShouldNotify(_InheritedCounter oldWidget) => true;
}

class MyCounter extends StatefulWidget {
  const MyCounter({
    super.key,
    required this.child,
  });

  final Widget child;

  static MyCounterState of(BuildContext context, {bool rebuild = true}) {
    return rebuild
        ? context.dependOnInheritedWidgetOfExactType<_InheritedCounter>()!.data
        : (context
        .getElementForInheritedWidgetOfExactType<_InheritedCounter>()!
        .widget as _InheritedCounter)
        .data;
  }

  @override
  State<MyCounter> createState() => MyCounterState();
}

class MyCounterState extends State<MyCounter> {
  int count = 0;

  void increment() => setState(() {
    count++;
  });

  @override
  Widget build(BuildContext context) {
    return _InheritedCounter(
      data: this,
      child: widget.child,
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyCounter(
      child: MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var counter = MyCounter.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('First Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'ボタンを押した回数',
                ),
                 CounterCard(counter: counter)
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counter.increment();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CounterCard extends StatelessWidget {
  const CounterCard({
    super.key,
    required this.counter,
  });

  final MyCounterState counter;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.settings_accessibility_outlined,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${counter.count}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ],
      ),
    );
  }
}
