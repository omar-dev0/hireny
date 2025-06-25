import 'package:flutter/material.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/constants/app_fonts.dart';
import 'package:intl/intl.dart';

class eventDialog extends StatefulWidget {
  final DateTime selectedDay;
  final Map<DateTime, List<String>> events;
  final TextEditingController eventController;

  const eventDialog({
    super.key,
    required this.selectedDay,
    required this.events,
    required this.eventController,
  });

  @override
  State<eventDialog> createState() => _eventDialogState();
}

class _eventDialogState extends State<eventDialog> {
  late TimeOfDay selectedTime;
  late bool hasEvent;

  @override
  void initState() {
    super.initState();
    selectedTime = TimeOfDay.now(); // Set initial time to current time
    // Normalize the selected day and check if events exist for that day
    DateTime normalizedSelectedDay = DateTime(widget.selectedDay.year, widget.selectedDay.month, widget.selectedDay.day);
    hasEvent = widget.events.containsKey(normalizedSelectedDay);
  }

  @override
  Widget build(BuildContext context) {
    // Normalize the selected day for comparison
    DateTime normalizedSelectedDay = DateTime(widget.selectedDay.year, widget.selectedDay.month, widget.selectedDay.day);

    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // If there are events for the selected day, show them
          if (hasEvent)
            ...widget.events[normalizedSelectedDay]!.map((event) {
              List<String> TheEvent = event.split(" ");
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                        alignment:Alignment.centerLeft,
                        child: Text("That day Event",style: AppFonts.mainText.copyWith(color: AppColors.primary),)
                    ),
                    SizedBox(height: 20,),
                    Text("Event : ${TheEvent[0]}",style: AppFonts.secMain.copyWith(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black),),
                    SizedBox(height: 10,),
                    Text("Time : ${TheEvent[3]}",style: AppFonts.secMain.copyWith(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black)),
                  ],
                ),
              );
            }).toList()
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
              child: Column(
                children: [
                  Text('Event for ${DateFormat('yyyy-MM-dd').format(widget.selectedDay)}',style: AppFonts.mainText,),
                  SizedBox(height: 10,),
                  TextField(
                    controller: widget.eventController,
                    decoration: InputDecoration(hintText: "Event Title",),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Time: ${selectedTime.format(context)}",style: AppFonts.textFieldStyle,),
                      SizedBox(width: 30),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.primary,
                        ),
                        onPressed: () async {
                          TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: selectedTime,
                          );
                          if (picked != null) {
                            setState(() {
                              selectedTime = picked;
                            });
                          }
                        },
                        child: Text("Select Time",style: AppFonts.buttonTextStyle.copyWith(fontSize: 14),),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
      actions: [
        // If no event exists, show 'Save' to add a new event
        if (!hasEvent)
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: AppColors.primary
            ),
            onPressed: () {
              if (widget.eventController.text.isNotEmpty) {
                final newEvent = '${widget.eventController.text} at ${selectedTime.format(context)}';

                // Normalize the date
                DateTime normalizedDate = DateTime(
                  widget.selectedDay.year,
                  widget.selectedDay.month,
                  widget.selectedDay.day,
                );

                setState(() {
                  widget.events.putIfAbsent(normalizedDate, () => []);
                  widget.events[normalizedDate]!.add(newEvent);
                });
              }
              Navigator.pop(context);
            },
            child: Text('Save',style: AppFonts.buttonTextStyle.copyWith(fontSize: 14),),
          ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Close'),
        ),
      ],
    );
  }
}


