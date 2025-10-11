import 'package:evently_app/common/network/events_service.dart';
import 'package:evently_app/models/event_model.dart';
import 'package:flutter/material.dart';

class EventsProvider extends ChangeNotifier {
  List<EventModel> eventsList = [];
  String? errorMessage;
  bool isLoading = false;
  int selectedCat = 1;
  getAllEvents() async {
    print('---->getAllEvents');
    isLoading = true;
    notifyListeners();
    try {
      eventsList = await EventsService.getAllEvents();
    } catch (e) {
      errorMessage = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  getFilteredEvents() async {
    print('---->getFilteredEvents$selectedCat');

    isLoading = true;
    notifyListeners();
    try {
      eventsList = await EventsService.getFilteredEvents(selectedCat);
    } catch (e) {
      errorMessage = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  editSelectedCat(int catId) async {
    // if (catId == selectedCat) return;
    selectedCat = catId;
    notifyListeners();
    if (selectedCat == 1) {
      await getAllEvents();
      return;
    } else {
      await getFilteredEvents();
    }
  }
}
