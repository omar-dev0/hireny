import 'package:flutter/material.dart';
import 'package:hireny/features/profile/presentation/views/widgets/customAppBar.dart';
import 'package:hireny/routes/page_route.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/constants/app_fonts.dart';
import 'package:hireny/utils/widgets/custome_appbar_drawer.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../core/widgets/sideBar.dart';
import 'Dialog.dart';
import 'customAppBar.dart';


class CalenderView extends StatefulWidget {
  const CalenderView({super.key});

  @override
  State<CalenderView> createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;


  final Map<DateTime, List<String>> _events = {
    DateTime(2025, 5, 6): ['Application deadline at 14:30'],
  };


  List<String> _getEventsForDay(DateTime day) {
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }


  Color _getEventColor(String event) {
    if (event.contains('Interview')) return Colors.lightBlue;
    if (event.contains('Application')) return Colors.orangeAccent;
    if (event.contains('Job Fair')) return Colors.blueGrey;
    return Colors.purple;
  }

  // Modified _addEventDialog to work with List<String> instead of List<Map<String, String>>
  void _addEventDialog(DateTime selectedDay) {
    TextEditingController eventController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return eventDialog(
                selectedDay: selectedDay,
                events: _events,
                eventController: eventController);
          },
        );
      },
    );
  }


  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    return
    CustomScreen(title: "Calender", drawer: SideBarScreen(currentRoute: PagesRoute.calender), body: Container(
      height: 500,
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 4,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            if (_selectedDay != null && isSameDay(_selectedDay, selectedDay)) {
              _selectedDay = null; // Deselect if clicked again
            } else {
              _selectedDay = selectedDay;
            }
            _focusedDay = focusedDay;
          });
          _addEventDialog(selectedDay);
        },
        eventLoader: _getEventsForDay,
        calendarBuilders: CalendarBuilders(
            markerBuilder: (context, date, events) {
              if (events.isEmpty) return SizedBox.shrink();
              final eventList = _getEventsForDay(date);
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: eventList.take(2).map((event) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 1),
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: _getEventColor(event),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      event,
                      style: TextStyle(
                        fontSize: 8,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
              );
            }
        ),
        calendarFormat: CalendarFormat.month,
        calendarStyle: CalendarStyle(
          selectedDecoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primary, width: 2),
            color: Colors.transparent,
          ),
          selectedTextStyle: TextStyle(color: AppColors.primary),
          todayDecoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
        ),
        headerStyle: HeaderStyle(
          titleTextStyle: AppFonts.secMain.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
          leftChevronIcon:
          Icon(Icons.chevron_left, color: AppColors.primary),
          rightChevronIcon:
          Icon(Icons.chevron_right, color: AppColors.primary),
        ),
      ),
    ));
  }
}



