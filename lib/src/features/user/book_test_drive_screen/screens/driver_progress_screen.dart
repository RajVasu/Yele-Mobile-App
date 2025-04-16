import 'package:flutter/material.dart';
import 'package:yele/src/core/widgets/custom_appbar.dart';
import 'package:yele/src/core/widgets/custom_bg_widget.dart';

class DriverProgressScreen extends StatefulWidget {
  const DriverProgressScreen({super.key});

  @override
  State<DriverProgressScreen> createState() => _DriverProgressScreenState();
}

class _DriverProgressScreenState extends State<DriverProgressScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomBgWidget(
      appBar: customAppBar(title: 'Driver\'s Progress'),

      body:
      //here map is to be shown, giveme the setps to do it
      Column(children: [
         
        ],
      ),
    );
  }
}
