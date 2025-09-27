import 'package:evently_app/common/widgets/event_card.dart';
import 'package:evently_app/models/event_model.dart';
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
          return EventCard(
            eventModel: EventModel(
              title: 'title$index',
              date: 'spt\n22',
              isFav: index % 2 == 0,
              id: index.toString(),
              categoryId: 2,
            ),
          );
        },
      ),
    );
  }
}
