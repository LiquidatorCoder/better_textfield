import 'package:flutter/services.dart';

class NativeTextViewController {
  NativeTextViewController()
      : _channel = const MethodChannel('NativeTextField');

  final MethodChannel _channel;

  Future<void> setText(String text) async {
    return _channel.invokeMethod('setText', {'text': text});
  }

  Future<String?> getText() async {
    return _channel.invokeMethod<String>('getText');
  }
}
