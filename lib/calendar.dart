import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SfCalendar(
      view: CalendarView.workWeek,
      timeSlotViewSettings: TimeSlotViewSettings(
          startHour: 9,
          endHour: 16,
          nonWorkingDays: <int>[DateTime.friday, DateTime.saturday]),
    ));
  }
}
