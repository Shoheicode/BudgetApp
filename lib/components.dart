import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class OpenSans extends StatelessWidget {
  final text;
  final size;
  final color;
  final fontWeight;
  const OpenSans(
      {Key? key,
      required this.text,
      required this.size,
      this.color,
      this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toString(),
      style: GoogleFonts.openSans(
        fontSize: size,
        color: color ?? Colors.black,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),
    );
  }
}

class Poppins extends StatelessWidget {
  final text;
  final size;
  final color;
  final fontWeight;
  const Poppins(
      {Key? key,
      required this.text,
      required this.size,
      this.color,
      this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toString(),
      style: GoogleFonts.poppins(
        fontSize: size,
        color: color ?? Colors.black,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),
    );
  }
}

class LineChartExample extends StatelessWidget {
  const LineChartExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter Line Chart")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: true),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
              bottomTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: true)),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: Colors.black, width: 1),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: [
                  FlSpot(0, 1),
                  FlSpot(1, 3),
                  FlSpot(2, 2),
                  FlSpot(3, 4),
                  FlSpot(4, 3),
                  FlSpot(5, 5),
                ],
                isCurved: true,
                barWidth: 4,
                belowBarData: BarAreaData(show: true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextForm extends StatelessWidget {
  final text;
  final containerWidth;
  final hintText;
  final controller;
  final digitsOnly;
  final validator;

  const TextForm({
    Key? key,
    required this.text,
    required this.containerWidth,
    required this.hintText,
    required this.controller,
    this.digitsOnly,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OpenSans(
          size: 13.0,
          text: text,
        ),
        const SizedBox(height: 5.0),
        SizedBox(
          width: containerWidth,
          child: TextFormField(
            validator: validator,
            inputFormatters: digitsOnly != null
                ? [FilteringTextInputFormatter.digitsOnly]
                : [],
            controller: controller,
            decoration: InputDecoration(
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.tealAccent, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(fontSize: 13.0),
            ),
          ),
        ),
      ],
    );
  }
}

DialogBox(BuildContext context, String title) {
  return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            contentPadding: const EdgeInsets.all(32.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: const BorderSide(width: 2.0, color: Colors.black),
            ),
            title: OpenSans(
              text: title,
              size: 20.0,
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                color: Colors.black,
                child: const OpenSans(
                  text: "Okay",
                  size: 20.0,
                  color: Colors.white,
                ),
              )
            ],
          ));
}
