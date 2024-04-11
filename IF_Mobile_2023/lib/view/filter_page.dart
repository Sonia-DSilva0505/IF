import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:internship_fair/constants/constants.dart';

class Filter extends StatefulWidget {
  const Filter(
      {super.key,
      required this.callback,
      required this.low,
      required this.high,
      required this.online,
      required this.offline,
      required this.mode,
      required this.isChanged});

  final Function(int, int, bool, bool, String mode, bool isChanged) callback;
  final int low, high;
  final bool online, offline;
  final String mode;
  final bool isChanged;

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  bool _isChecked = false;
  bool _isCorrected = false;
  SfRangeValues _values = const SfRangeValues(0.0, 50000.0);
  int low = 0, high = 50000;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.offline;
    _isCorrected = widget.online;
    low = widget.low;
    high = widget.high;
    _values = SfRangeValues(widget.low.toDouble(), widget.high.toDouble());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double sizefont = size.width * 0.04;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.filter_alt_sharp, color: Colors.teal),
                SizedBox(width: size.width * 0.01),
                SizedBox(height: size.height * 0.12),
                Text(
                  "Filters",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: sizefont * 1.7,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                right: size.width * 0.68,
              ),
              child: const Text(
                "STIPEND",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            SizedBox(
              width: size.width * 0.958,
              child: SfRangeSlider(
                labelFormatterCallback:
                    (dynamic actualValue, String formattedText) {
                  var formattedText = NumberFormat.compactCurrency(
                    symbol: '₹',
                    decimalDigits: 0,
                  ).format(actualValue);
                  return ' $formattedText';
                },
                showDividers: true,
                enableTooltip: true,
                tooltipTextFormatterCallback:
                    (dynamic actualValue, String formattedText) {
                  actualValue = actualValue.round() - actualValue.round() % 500;
                  return actualValue.toStringAsFixed(00);
                },
                inactiveColor: darkgrey,
                activeColor: blackTeal,
                min: 0,
                max: 50000,
                values: _values,
                interval: 10000,
                showLabels: true,
                onChanged: (SfRangeValues newValues) {
                  setState(() {
                    _values = newValues;
                  });
                  low = _values.start.round() - _values.start.round() % 500;
                  high = _values.end.round() - _values.end.round() % 500;
                },
              ),
            ),
            Column(
              children: [
                SizedBox(height: size.height * 0.05),
                Padding(
                  padding: EdgeInsets.only(
                    right: size.width * 0.7,
                    top: size.height * 0.0005,
                  ),
                  child: const Text(
                    "MODE",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: _isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _isChecked = value ?? false;
                          });
                        },
                        activeColor: Colors.teal,
                        checkColor: Colors.white,
                      ),
                      const Text(
                        "Offline",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: _isCorrected,
                        onChanged: (bool? value) {
                          setState(() {
                            _isCorrected = value ?? false;
                          });
                        },
                        activeColor: Colors.teal,
                        checkColor: Colors.white,
                      ),
                      const Text(
                        'Online',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.005,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                      onPressed: () async {
                        if ((_isCorrected == false && _isChecked == false) ||
                            (_isChecked == true && _isCorrected == true)) {
                          Navigator.pop(context);

                          widget.callback(
                              low, high, _isCorrected, _isChecked, "", true);
                        } else if (_isCorrected == true &&
                            _isChecked == false) {
                          Navigator.pop(context);
                          widget.callback(low, high, _isCorrected, _isChecked,
                              'Online', true);
                        } else if (_isChecked == true &&
                            _isCorrected == false) {
                          Navigator.pop(context);
                          widget.callback(low, high, _isCorrected, _isChecked,
                              'Offline', true);
                        }
                      },
                      child: FittedBox(
                        child: Text(
                          "Apply",
                          style: TextStyle(
                              fontSize: sizefont * 1.11,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                              color: Colors.teal),
                        ),
                      )),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        widget.callback(0, 50000, false, false, "", true);
                      },
                      child: FittedBox(
                        child: Text(
                          "Clear All",
                          style: TextStyle(
                              fontSize: sizefont * 1.11,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                              color: Colors.teal),
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
