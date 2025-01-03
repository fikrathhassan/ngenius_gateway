import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:ngenius/ngenius.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _ngeniusPlugin =
      Ngenius(apiKey: 'your_api_key', outletId: 'your_outlet_id');

  // @override
  // void initState() {
  //   super.initState();
  //   initPlatformState();
  // }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion = "";
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _ngeniusPlugin.createOrder(amount: '100', currency: 'USD') ??
              'Unknown platform version';
    } on PlatformException catch(e) {
      platformVersion = e.message ?? "Platform exception";
    } finally {
      print(platformVersion);
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: TextButton(
            onPressed: initPlatformState,
            child: Text('Create Order'),
          ),
        ),
      ),
    );
  }
}
