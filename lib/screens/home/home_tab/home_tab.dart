import 'package:evently_app/screens/home/home_tab/views/events_list_view.dart';
import 'package:evently_app/screens/home/home_tab/views/home_header.dart';
import 'package:flutter/widgets.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [HomeHeader(), EventsListView()]);
  }
}
