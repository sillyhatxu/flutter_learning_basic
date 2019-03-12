import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/config.json');
}


void main() {
  Future<String> test = rootBundle.loadString('config.json');

  print(test);
}