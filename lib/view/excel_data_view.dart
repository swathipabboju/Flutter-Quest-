import 'package:flutter/material.dart';

class ExcelDataView extends StatefulWidget {
  final String title;
  const ExcelDataView({super.key, required this.title});

  @override
  State<ExcelDataView> createState() => _ExcelDataViewState();
}

class _ExcelDataViewState extends State<ExcelDataView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.lightBlue,
                disabledForegroundColor: Colors.grey,
              ),
              onPressed: generateExcel,
              child: const Text('Generate Excel'),
            )
          ],
        ),
      ),
    );
  }

  generateExcel() {
    
  }
}
