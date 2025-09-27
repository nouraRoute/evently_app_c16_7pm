import 'package:evently_app/common/widgets/event_card.dart';
import 'package:flutter/widgets.dart';

class EventsListView extends StatelessWidget {
  const EventsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 8),
        itemCount: 10,
        itemBuilder: (context, index) {
          return EventCard();
        },
      ),
    );
  }
}
