import 'package:flutter/material.dart';
import 'package:test_app/constants/palette.dart';
import 'package:test_app/models/terminal.dart';

class TerminalWidgetAppBarTitle extends StatelessWidget {
  final Terminal terminal;

  const TerminalWidgetAppBarTitle({Key key, this.terminal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(terminal.name ?? ''),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(terminal.title,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 11,
                    color: Colors.white)),
            SizedBox(width: 4),
            Text(terminal.subTitle,
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 11,
                    color: iconColor)),
          ],
        ),
      ],
    );
  }
}
