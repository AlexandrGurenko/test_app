import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_app/constants/palette.dart';
import 'package:test_app/models/terminal.dart';

class TerminalWidgetDetails extends StatelessWidget {
  final Terminal terminal;
  final VoidCallback onTapTerminalDetail;

  const TerminalWidgetDetails(
      {Key key, this.terminal, this.onTapTerminalDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/images/points.svg',
            color: Colors.white,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 19),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(terminal.name ?? '',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Colors.white)),
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
              ),
            ),
          ),
          InkWell(
              onTap: onTapTerminalDetail,
              child: SvgPicture.asset('assets/images/24h.svg')),
        ],
      ),
    );
  }
}
