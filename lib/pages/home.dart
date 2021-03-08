import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_app/constants/palette.dart';
import 'package:test_app/models/airport.dart';
import 'package:test_app/models/terminal.dart';
import 'package:test_app/pages/exchange_points/exchange_points_about_terminal.dart';
import 'package:test_app/pages/exchange_points/exchange_points_airports.dart';
import 'package:test_app/pages/exchange_points/exchange_points_terminal.dart';
import 'package:test_app/pages/notification_page.dart';
import 'package:test_app/widgets/terminal_widget_app_bar_title.dart';

import 'exchange_points/exchange_points_details.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedBottomBarItem = 1;
  int _currentExchangePointPageIndex = 1;
  Airport _selectedAirport;
  Terminal _selectedTerminal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        title: setPageTitle(),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            if (_currentExchangePointPageIndex != 1) {
              setState(() {
                _currentExchangePointPageIndex--;
              });
            } else {
              // Navigator.pop(context);
            }
          },
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: iconColor,
          ),
        ),
        actions: _currentExchangePointPageIndex != 4
            ? [
                SvgPicture.asset('assets/images/info.svg'),
                SizedBox(width: 4),
                SvgPicture.asset('assets/images/private_office.svg'),
                SizedBox(width: 16)
              ]
            : [],
      ),
      body: LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: buildBody(),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        currentIndex: _selectedBottomBarItem,
        backgroundColor: primaryColor,
        selectedIconTheme: IconThemeData(color: activeColor),
        selectedItemColor: Colors.white,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        unselectedItemColor: iconColor,
        items: buildBottomBar(),
        onTap: onBottomBarItemTap,
      ),
    );
  }

  List<BottomNavigationBarItem> buildBottomBar() {
    return [
      BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/images/currencies.svg'),
          activeIcon: SvgPicture.asset('assets/images/currencies.svg',
              color: activeColor),
          label: 'Валюты'),
      BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/images/points.svg'),
          activeIcon:
              SvgPicture.asset('assets/images/points.svg', color: activeColor),
          label: 'Пункты'),
      BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/images/exchange.svg'),
          activeIcon: SvgPicture.asset('assets/images/exchange.svg',
              color: activeColor),
          label: 'Обмен'),
      BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/images/bottom_info_ic.svg'),
          activeIcon: SvgPicture.asset('assets/images/bottom_info_ic.svg',
              color: activeColor),
          label: 'Инфо'),
      BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/images/menu.svg'),
          activeIcon:
              SvgPicture.asset('assets/images/menu.svg', color: activeColor),
          label: 'Меню'),
    ];
  }

  void onBottomBarItemTap(int index) {
    setState(() {
      _selectedBottomBarItem = index;
    });
  }

  Widget buildBody() {
    switch (_selectedBottomBarItem) {
      case 1:
        return exchangePointsAirports(_currentExchangePointPageIndex);
      case 3:
        return NotificationPage();
      default:
        return ExchangePointsAirports();
    }
  }

  Widget exchangePointsAirports(int index) {
    switch (index) {
      case 1:
        return ExchangePointsAirports(
            pageIndex: index,
            callback: pageIndexChanged,
            selectedAirportChanged: setSelectedAirport);
      case 2:
        return ExchangePointsTerminal(
            pageIndex: index,
            callback: pageIndexChanged,
            selectedAirport: _selectedAirport,
            terminalCallback: setSelectedTerminal);
      case 3:
        return ExchangePointsDetails(
            pageIndex: index,
            callback: pageIndexChanged,
            terminal: _selectedTerminal);
      case 4:
        return ExchangePointsAboutTerminal();
      default:
        return ExchangePointsAirports();
    }
  }

  void pageIndexChanged(int index) {
    setState(() {
      _currentExchangePointPageIndex = index;
    });
  }

  void setSelectedAirport(Airport airport) {
    _selectedAirport = airport;
  }

  void setSelectedTerminal(Terminal terminal) {
    _selectedTerminal = terminal;
  }

  Widget setPageTitle() {
    switch (_currentExchangePointPageIndex) {
      case 1:
      case 2:
        return Text('Пункты обмена');
      case 3:
        return Text('Подробности');
      case 4:
        return TerminalWidgetAppBarTitle(terminal: _selectedTerminal);
      default:
        return Text('');
    }
  }
}
