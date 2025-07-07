import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:hireny/features/auth/view/widgets/choice_widget.dart';
import 'package:hireny/features/calender/domain/models/event.dart';
import 'package:hireny/features/calender/ui/cubit/calender_cubit.dart';
import 'package:hireny/features/calender/ui/widgets/add_event_bottom_sheet.dart';
import 'package:hireny/features/calender/ui/widgets/show_event_bottom_sheet.dart';
import 'package:hireny/routes/page_route.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/widgets/custome_appbar_drawer.dart';
import '../../../../../core/widgets/sideBar.dart';

class CalenderView extends StatefulWidget {
  final List<EventModel> events;
  const CalenderView({super.key, required this.events});

  @override
  State<CalenderView> createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView> {
  DateTime selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    CalenderCubit calenderCubit = context.read<CalenderCubit>();

    return CustomScreen(
      title: "Calender",
      drawer: SideBarScreen(currentRoute: PagesRoute.calender),
      body: FadeInUp(
        duration: Duration(milliseconds: 400),
        child: Container(
          height: 500,
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: TableCalendar(
            eventLoader: (day) {
              return calenderCubit.events[
              DateTime(day.year, day.month, day.day)
              ] ??
              [];
            },
            focusedDay: selectedDay,
            firstDay: DateTime.now().subtract(Duration(days: 365)),
            lastDay: DateTime.now().add(Duration(days: 365)),
            currentDay: DateTime.now(),
            selectedDayPredicate: (day) => isSameDay(day, selectedDay),
            onDaySelected: (date, focusedDay) {
              setState(() {
                selectedDay = date;
              });

              showDialog(
                context: context,
                builder: (_) => ChoiceDialog(
                  message: 'Select',
                  button1Text: 'Show Events in Day',
                  button2Text: 'Add Event',
                  iconButton1: Icon(Icons.event, color: AppColors.white),
                  iconButton2: Icon(Icons.add, color: AppColors.primary),
                  onPressButton1: () {
                    Navigator.pop(context);
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) {
                        return ViewEventsBottomSheet(
                          date: selectedDay,
                          events: calenderCubit.events[
                          DateTime(selectedDay.year, selectedDay.month, selectedDay.day)] ??
                              [],
                        );
                      },
                    );
                  },
                  onPressButton2: () {
                    Navigator.pop(context);
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (_) {
                        return AddEventBottomSheet(
                          selectedDay: selectedDay,
                          onEventAdded: (String title, TimeOfDay time) async{
                            await calenderCubit.addEvent(
                              EventModel(
                                title: title,
                                startDate: DateTime(
                                  date.year,
                                  date.month,
                                  date.day,
                                  time.hour,
                                  time.minute,
                                ),
                              ),
                            );
                            setState(() {

                            });
                          },
                        );
                      },
                    );
                  },
                ),
              );
            },
            calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              outsideDaysVisible: false,
              todayDecoration: BoxDecoration(
                color: AppColors.green,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withOpacity(0.7),
                  ],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.4),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              weekendTextStyle: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
              selectedTextStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              todayTextStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
              leftChevronIcon:
              Icon(Icons.chevron_left, color: AppColors.primary),
              rightChevronIcon:
              Icon(Icons.chevron_right, color: AppColors.primary),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekendStyle: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.w600,
              ),
              weekdayStyle: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                if (events.isEmpty) return SizedBox();
                return Positioned(
                  bottom: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(events.length.clamp(0, 3), (index) {
                      return Container(
                        width: 5,
                        height: 5,
                        margin: EdgeInsets.symmetric(horizontal: 1),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                      );
                    }),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
