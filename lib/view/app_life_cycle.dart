import 'package:flutter/material.dart';

class MyAppLifecycleObserver extends StatefulWidget {
  @override
  _MyAppLifecycleObserverState createState() => _MyAppLifecycleObserverState();
}

class _MyAppLifecycleObserverState extends State<MyAppLifecycleObserver>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        print("App is inactive");
        break;
      case AppLifecycleState.resumed:
        print("App is resumed");
        break;
      case AppLifecycleState.paused:
        print("App is paused");
        break;
      case AppLifecycleState.detached:
        print("App is detached");
        break;
      case AppLifecycleState.hidden:
        print("App is hidden");
        break;
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("App Lifecycle Example")),
      body: Center(child: Text("Observe app lifecycle changes")),
    );
  }
}


