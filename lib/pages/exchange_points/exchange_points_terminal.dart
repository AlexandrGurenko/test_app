import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_app/constants/palette.dart';
import 'package:test_app/models/airport.dart';
import 'package:test_app/models/terminal.dart';
import 'package:test_app/widgets/CustomButton.dart';
import 'package:test_app/widgets/airport_widget.dart';
import 'package:test_app/widgets/terminal_widget.dart';

import 'exchange_points_airports.dart';

typedef TerminalCallback(Terminal terminal);

class ExchangePointsTerminal extends StatefulWidget {
  final IntCallback callback;
  final int pageIndex;
  final Airport selectedAirport;
  final TerminalCallback terminalCallback;

  const ExchangePointsTerminal(
      {Key key,
      this.callback,
      this.pageIndex,
      this.selectedAirport,
      this.terminalCallback})
      : super(key: key);

  @override
  _ExchangePointsTerminalState createState() => _ExchangePointsTerminalState();
}

class _ExchangePointsTerminalState extends State<ExchangePointsTerminal> {
  final _scrollController = FixedExtentScrollController();
  double _itemHeight = 60;

  List<Terminal> terminals = [
    Terminal(title: '1 этфаж', subTitle: '(зона прилетов)'),
    Terminal(
        name: 'Терминал D',
        title: '2 этфаж',
        subTitle: '(вход с терминаа паркинга)'),
    Terminal(name: 'Терминал F', title: '3 этфаж', subTitle: '(зона вылетов)'),
    Terminal(title: '4 этфаж', subTitle: '(зона Duty free)'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: SvgPicture.asset(
              'assets/images/paper_plane.svg',
              height: 102,
            )),
        Text(
          'аэропорт:'.toUpperCase(),
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 14,
              fontStyle: FontStyle.italic),
        ),
        Container(
            decoration: BoxDecoration(color: accentColor, boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  offset: Offset(0.0, 0.0), //(x,y)
                  blurRadius: 6.0),
            ]),
            margin: const EdgeInsets.only(top: 15, bottom: 45),
            padding: const EdgeInsets.symmetric(vertical: 9),
            child:
                Center(child: AirportWidget(airport: widget.selectedAirport))),
        RichText(
          text: TextSpan(
            text: 'Выберите '.toUpperCase(),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 14,
                fontStyle: FontStyle.italic),
            children: [
              TextSpan(
                text: 'терминал'.toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: activeColor,
                    fontStyle: FontStyle.italic),
              ),
              TextSpan(
                text: ':'.toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: _itemHeight,
                color: Color(0xFF25476F).withOpacity(0.67),
              ),
              ClickableListWheelScrollView(
                scrollController: _scrollController,
                itemHeight: _itemHeight,
                itemCount: terminals.length,
                onItemTapCallback: (index) {
                  widget.terminalCallback(terminals[index]);
                },
                child: ListWheelScrollView.useDelegate(
                  controller: _scrollController,
                  itemExtent: _itemHeight,
                  physics: FixedExtentScrollPhysics(),
                  overAndUnderCenterOpacity: 0.5,
                  onSelectedItemChanged: (index) {
                    widget.terminalCallback(terminals[index]);
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                      childCount: terminals.length,
                      builder: (BuildContext context, int index) {
                        return TerminalWidget(terminal: terminals[index],);
                      }),
                ),
              ),
            ],
          ),
        ),
        CustomButton(
          title: 'Продолжить',
          callback: () {
            widget.callback(widget.pageIndex + 1);
          },
        ),
      ],
    );
  }
}
