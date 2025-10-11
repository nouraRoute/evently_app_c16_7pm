import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/models/event_model.dart';

class EventsService {
  static Future<List<EventModel>> getAllEvents() async {
    CollectionReference<EventModel> collection = _getEventsCollection();
    QuerySnapshot<EventModel> snapshot = await collection.get();
    List<EventModel> events = snapshot.docs.map((e) => e.data()).toList();
    return events;
  }

  static Future<List<EventModel>> getFilteredEvents(int catId) async {
    CollectionReference<EventModel> collection = _getEventsCollection();
    QuerySnapshot<EventModel> snapshot = await collection
        .where('categoryId', isEqualTo: catId)
        .get();
    List<EventModel> events = snapshot.docs.map((e) => e.data()).toList();
    return events;
  }

  static Future<void> createNewEvent(EventModel event) async {
    CollectionReference<EventModel> collection = _getEventsCollection();
    DocumentReference doc = collection.doc();
    event.id = doc.id;
    await doc.set(event);
  }

  static CollectionReference<EventModel> _getEventsCollection() {
    CollectionReference<EventModel> collection = FirebaseFirestore.instance
        .collection('events')
        .withConverter(
          fromFirestore: (snapshot, options) =>
              EventModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
    return collection;
  }
}
