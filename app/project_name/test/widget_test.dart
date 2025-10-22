import 'package:core_test/ex.dart';
import 'package:feature_test/ex.dart';
import 'package:flutter/material.dart';

class WidgetTest extends StatefulWidget {
  const WidgetTest({super.key});

  @override
  State<WidgetTest> createState() => _WidgetTestState();
}

class _WidgetTestState extends State<WidgetTest> {
  @override
  Widget build(BuildContext context) {
    return HI();
  }
}
