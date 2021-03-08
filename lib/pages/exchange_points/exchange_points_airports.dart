import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_app/constants/palette.dart';
import 'package:test_app/widgets/CustomButton.dart';
import 'package:test_app/models/airport.dart';
import 'package:test_app/widgets/airport_widget.dart';

typedef IntCallback(int index);
typedef AirportCallback(Airport airport);

class ExchangePointsAirports extends StatefulWidget {
  final IntCallback callback;
  final AirportCallback selectedAirportChanged;
  final int pageIndex;

  const ExchangePointsAirports(
      {Key key, this.callback, this.pageIndex, this.selectedAirportChanged})
      : super(key: key);

  @override
  _ExchangePointsAirportsState createState() => _ExchangePointsAirportsState();
}

class _ExchangePointsAirportsState extends State<ExchangePointsAirports> {
  List<Airport> airports = [
    Airport(name: 'Львов', img: 'assets/images/lviv.png', id: 1),
    Airport(name: 'Харьков', img: 'assets/images/kharkiv.png', id: 2),
    Airport(name: 'Борисполь', img: 'assets/images/borispol.png', id: 3),
    Airport(name: 'Жуляны', img: 'assets/images/zhulyany.png', id: 4),
    Airport(name: 'Одесса', img: 'assets/images/odessa.png', id: 5)
  ];

  Airport _selectedAirport;
  int _availableAirportId = 3;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SvgPicture.asset('assets/images/paper_plane.svg')),
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
                text: 'Аэропорт'.toUpperCase(),
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
        SizedBox(height: 4),
        Text(
          'на данный момент доступен только борисполь'.toUpperCase(),
          style: TextStyle(
              fontSize: 9,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic),
        ),
        SizedBox(height: 30),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: CupertinoPicker(
                  diameterRatio: 1,
                  itemExtent: 50,
                  onSelectedItemChanged: (index) {
                    _selectedAirport = airports[index];
                    widget.selectedAirportChanged(_selectedAirport);
                  },
                  children: List<Widget>.generate(
                    airports.length,
                    (index) {
                      return AirportWidget(
                        airport: airports[index],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        CustomButton(
          title: 'Продолжить',
            callback: () {
          if (_availableAirportId == _selectedAirport.id)
            widget.callback(widget.pageIndex + 1);
          else
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text('Выбранный аэропорт недоступен'),
              duration: const Duration(seconds: 2),
            ));
        }),
      ],
    );
  }
}
