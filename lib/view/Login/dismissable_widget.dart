import 'package:flutter/material.dart';

class DismissableWidgetScreen extends StatefulWidget {
  const DismissableWidgetScreen({super.key});

  @override
  State<DismissableWidgetScreen> createState() =>
      _DismissableWidgetScreenState();
}

class _DismissableWidgetScreenState extends State<DismissableWidgetScreen> {
  List<String> items =
      List<String>.generate(10, (index) => "Item ${index + 1}");
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Dismissible(
              key: Key(item),
              onDismissed: (direction) {
                setState(() {
                  items.removeAt(index);
                });
              },
              background: Container(
                color: Colors.red,
              ),
              child: ListTile(
                title: Text(item),
              ),
            );
          }),
    );
  }
}
