import 'package:evently_app/common/network/events_service.dart';
import 'package:evently_app/common/widgets/custom_main_button.dart';
import 'package:evently_app/models/event_model.dart';
import 'package:evently_app/providers/events_provider.dart';
import 'package:evently_app/screens/home/home_tab/views/events_list_view.dart';
import 'package:evently_app/screens/home/home_tab/views/home_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EventsProvider>(
      builder: (context, value, _) => Column(
        children: [
          HomeHeader(),
          if (value.isLoading)
            Expanded(child: Center(child: CircularProgressIndicator()))
          else if (value.errorMessage != null)
            Expanded(
              child: Center(
                child: Column(
                  children: [
                    Text(value.errorMessage!),
                    CustomMainButton(
                      text: 'Refresh',
                      onPressed: () {
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            )
          else
            EventsListView(events: value.eventsList),
        ],
      ),
    );
  }
}
