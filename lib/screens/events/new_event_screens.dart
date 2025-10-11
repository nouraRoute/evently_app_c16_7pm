import 'package:evently_app/common/network/events_service.dart';
import 'package:evently_app/common/theme/app_colors.dart';
import 'package:evently_app/common/widgets/custom_main_button.dart';
import 'package:evently_app/common/widgets/custom_text_field.dart';
import 'package:evently_app/models/category_model.dart';
import 'package:evently_app/models/event_model.dart';
import 'package:evently_app/providers/events_provider.dart';
import 'package:evently_app/screens/events/views/category_selector_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Event')),
      body: Form(
        key: _formKey,
        child: ListView(
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
              controller: titleController,
              title: 'Title',
              hintText: 'Event Title',
              prefixIcon: Icon(Icons.edit_outlined),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'title is required';
                }
                return null;
              },
            ),
            SizedBox(height: 16),

            CustomTextField(
              title: 'Description',
              hintText: 'Event Description',
              maxLines: 5,
              controller: descriptionController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'description is required';
                }
                return null;
              },
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
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.mainColor,
                    ),
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
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.mainColor,
                    ),
                  ),
                ),
              ],
            ),
            CustomMainButton(
              text: 'Add Event',
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  if (selectedDate != null && selectedTime != null) {
                    showDialog(
                      context: context,
                      builder: (context) => Center(
                        child: Container(
                          padding: EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                    selectedDate = selectedDate!.copyWith(
                      hour: selectedTime!.hour,
                      minute: selectedTime!.minute,
                    );
                    EventModel eventModel = EventModel(
                      title: titleController.text,
                      description: descriptionController.text,
                      date: DateFormat(
                        'yyyy-MM-dd hh:mm',
                      ).format(selectedDate!),
                      isFav: false,
                      categoryId: selectedCatId,
                    );

                    try {
                      await EventsService.createNewEvent(eventModel);
                      Fluttertoast.showToast(
                        msg: 'success',
                        backgroundColor: Colors.green,
                      );
                      print('----->done');
                      await Provider.of<EventsProvider>(
                        context,
                        listen: false,
                      ).editSelectedCat(1);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    } catch (e) {
                      Navigator.of(context).pop();

                      Fluttertoast.showToast(
                        backgroundColor: Colors.red.withValues(alpha: .7),
                        msg: e.toString(),
                      );
                    }
                  } else {
                    Fluttertoast.showToast(
                      backgroundColor: Colors.red.withValues(alpha: .7),
                      msg: 'date and time are required',
                    );
                  }
                }
              },
            ),
          ],
        ),
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
