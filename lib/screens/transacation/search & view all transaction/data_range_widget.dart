import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

DateTime? first;
DateTime? second;

class WidgetDateRange extends StatefulWidget {
  const WidgetDateRange({super.key});

  @override
  State<WidgetDateRange> createState() => _WidgetDateRangeState();
}

class _WidgetDateRangeState extends State<WidgetDateRange> {
  DateTime? _startDate;
  DateTime? _endDate;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
            onPressed: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: _startDate ?? DateTime.now(),
                firstDate: DateTime(2022),
                lastDate: DateTime.now(),
              );
              if (date == null) {
                return;
              } else {
                setState(() {
                  _startDate = date;
                });
                first = _startDate;
              }
              // print(date);
            },
            child: Text(_startDate == null ? 'From' : parseDate(_startDate!))),
        TextButton(
            onPressed: () async {
              DateTime? date = await showDatePicker(
                  context: context,
                  initialDate:
                      _startDate != null ? _startDate! : DateTime.now(),
                  firstDate: _startDate != null ? _startDate! : DateTime.now(),
                  lastDate: DateTime.now());
              if (date != null) {
                setState(() {
                  _endDate = date;
                });
                second = _endDate;
              }
              // print(date);
            },
            child: Text(_endDate == null ? 'To' : parseDate(_endDate!))),
        const CircleAvatar(
          child: Icon(
            Icons.check,
            color: Colors.black,
          ),
        )
      ],
    );
  }

  String parseDate(DateTime date) {
    final parsedDate = DateFormat.yMMMd().format(date);
    final splittedDate = parsedDate.split(' ');
    return '${splittedDate.elementAt(1)} ${splittedDate.elementAt(0)} ${splittedDate.elementAt(2)}';
  }
}