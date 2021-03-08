import 'package:flutter/material.dart';
import 'package:test_app/constants/palette.dart';
import 'package:test_app/models/terminal.dart';

class TerminalWidget extends StatelessWidget {
  final Terminal terminal;

  const TerminalWidget({Key key, this.terminal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Center(child: Text(terminal.name ?? '', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.white)))),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(terminal.title, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.white)),
              Text(terminal.subTitle, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: iconColor)),
            ],
          ),
        )
      ],
    );
  }
}
