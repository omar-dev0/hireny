import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class ViewEventsBottomSheet extends StatelessWidget {
  final DateTime date;
  final List<String> events;

  const ViewEventsBottomSheet({
    Key? key,
    required this.date,
    required this.events,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedDate = "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.all(16),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.6,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: FadeInUp(
          duration: Duration(milliseconds: 400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 5,
                margin: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Text(
                "Events on $formattedDate",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: events.isEmpty
                    ? Center(
                  child: Text(
                    'No events for this day.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                )
                    : ListView.separated(
                  itemCount: events.length,
                  separatorBuilder: (_, __) => Divider(height: 12),
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.event_note, color: Colors.deepPurple),
                      title: Text(
                        events[index],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
