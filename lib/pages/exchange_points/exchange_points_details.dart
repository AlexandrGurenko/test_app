import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:test_app/constants/palette.dart';
import 'package:test_app/models/terminal.dart';
import 'package:test_app/pages/exchange_points/exchange_points_airports.dart';
import 'package:test_app/utils/location.dart';
import 'package:test_app/widgets/CustomButton.dart';
import 'package:test_app/widgets/terminal_widget_details.dart';

class ExchangePointsDetails extends StatefulWidget {
  final Terminal terminal;
  final IntCallback callback;
  final int pageIndex;

  ExchangePointsDetails({Key key, this.terminal, this.callback, this.pageIndex})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExchangePointsDetailsState();
}

class _ExchangePointsDetailsState extends State<ExchangePointsDetails> {
  int _currentImageIndex = 0;

  final List<String> images = [
    'assets/images/image.png',
    'assets/images/image.png',
    'assets/images/image.png',
    'assets/images/image.png',
    'assets/images/image.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 45),
              child: Column(
                children: [
                  CarouselSlider.builder(
                    itemCount: images.length,
                    itemBuilder: (context, index, idx) {
                      return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Image.asset(
                            images[index],
                            fit: BoxFit.cover,
                          ));
                    },
                    options: CarouselOptions(
                        autoPlay: false,
                        // enlargeCenterPage: true,
                        height: MediaQuery.of(context).size.width,
                        viewportFraction: 1.0,
                        enlargeCenterPage: false,
                        onPageChanged: (index, _) {
                          setState(() {
                            _currentImageIndex = index;
                          });
                        }),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(images.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 3.0),
                        child: Icon(
                          Icons.fiber_manual_record,
                          size: 10,
                          color: _currentImageIndex == index
                              ? Colors.white
                              : Colors.white.withOpacity(0.33),
                        ),
                      );
                    }),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  color: primaryColor),
              child: TerminalWidgetDetails(
                terminal: widget.terminal,
                onTapTerminalDetail: () {
                  widget.callback(widget.pageIndex + 1);
                },
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Text(
            'Sed consectetur convallis parturient suscipit commodo. Potenti habitant semper nunc tincidunt dignissim. ???Et mauris aenean porttitor nunc, phasellus dui ultrices integer. Mattis quam tincidunt molestie viverra in hendrerit mattis quis. Urna faucibus ultrices arcu.',
            style: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 12, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        CustomButton(
          title: '?????????????????? ??????????????',
          callback: () {
            determinePosition().then((position) {
              if (position != null) {
                showBottomSheet(position);
              }
            });
          },
        ),
      ],
    );
  }

  void showBottomSheet(Position position) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 36.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0),
                    color: Color(0xFF252525),
                  ),
                  child: Column(
                    children: [
                      CupertinoButton(
                          child: Text('?????????????? ?? ??????????'),
                          onPressed: () {
                            launchMapsUrl(
                                position.latitude, position.longitude);
                            Navigator.pop(context);
                          }),
                      Divider(color: Color(0xFFD9D9D9).withOpacity(0.7)),
                      CupertinoButton(
                          child: Text('?????????????? ?? Google ??????????'),
                          onPressed: () {
                            launchMapsUrl(position.latitude, position.longitude,
                                google: true);
                            Navigator.pop(context);
                          }),
                    ],
                  ),
                ),
                SizedBox(height: 8.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0),
                    color: Color(0xFF2C2C2E),
                  ),
                  child: CupertinoButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('????????????'),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
