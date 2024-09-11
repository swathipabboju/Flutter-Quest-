import 'package:flutter/material.dart';

class WhishListPage extends StatefulWidget {
  const WhishListPage({super.key});

  @override
  State<WhishListPage> createState() => _WhishListPageState();
}

class _WhishListPageState extends State<WhishListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Whishlist Details"),
      ),
    );
  }
}
