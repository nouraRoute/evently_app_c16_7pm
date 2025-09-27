import 'package:evently_app/common/theme/app_colors.dart';
import 'package:evently_app/common/widgets/custom_main_button.dart';
import 'package:evently_app/common/widgets/custom_text_field.dart';
import 'package:evently_app/models/category_model.dart';
import 'package:evently_app/screens/events/views/category_selector_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewEventScreen extends StatefulWidget {
  const NewEventScreen({super.key});
  static const String routeName = '/new_event_screen';

  @override
  State<NewEventScreen> createState() => _NewEventScreenState();
}

class _NewEventScreenState extends State<NewEventScreen> {
  DateTime? selectedDate; //yyyy MM dd mm ss
  TimeOfDay? selectedTime; //mm ss
  int selectedCatId = CategoryModel.categories[1].id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Event')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          CategorySelectorView(
            selectedCatId: selectedCatId,
            onChanged: (id) {
              setState(() {
                selectedCatId = id;
              });
            },
          ),
          SizedBox(height: 16),
          CustomTextField(
            title: 'Title',
            hintText: 'Event Title',
            prefixIcon: Icon(Icons.edit_outlined),
          ),
          SizedBox(height: 16),

          CustomTextField(
            title: 'Description',
            hintText: 'Event Description',
            maxLines: 5,
          ),
          Row(
            children: [
              Icon(Icons.date_range_sharp),
              SizedBox(width: 10),
              Text(
                'Event Date',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Spacer(),
              TextButton(
                onPressed: () async {
                  DateTime? date = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2050),
                    initialDate: selectedDate,
                  );
                  if (date != null) {
                    setState(() {
                      selectedDate = date;
                    });
                  }
                },
                child: Text(
                  dateFormatted(),
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(color: AppColors.mainColor),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.watch_later_outlined),
              SizedBox(width: 10),
              Text(
                'Event Time',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Spacer(),
              TextButton(
                onPressed: () async {
                  TimeOfDay? time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time != null) {
                    setState(() {
                      selectedTime = time;
                    });
                  }
                },
                child: Text(
                  timeFormatted(),
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(color: AppColors.mainColor),
                ),
              ),
            ],
          ),
          CustomMainButton(text: 'Add Event', onPressed: () {}),
        ],
      ),
    );
  }

  String dateFormatted() {
    return selectedDate == null
        ? 'Choose Date'
        : DateFormat.yMMMd().format(selectedDate!);

    //'${selectedDate!.year},${selectedDate!.month},${selectedDate!.day}';
  }

  String timeFormatted() {
    return selectedTime == null ? 'Choose Time' : selectedTime!.format(context);

    //'${selectedDate!.year},${selectedDate!.month},${selectedDate!.day}';
  }
}
