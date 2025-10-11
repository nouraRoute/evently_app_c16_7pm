import 'package:evently_app/common/network/auth_service.dart';
import 'package:evently_app/common/theme/app_colors.dart';
import 'package:evently_app/models/category_model.dart';
import 'package:evently_app/models/event_model.dart';
import 'package:evently_app/models/user_model.dart';
import 'package:evently_app/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.eventModel});
  final EventModel eventModel;
  @override
  Widget build(BuildContext context) {
    bool isFav =
        (Provider.of<CurrantAuthProvider>(context).userModel?.favEvents ?? [])
            .indexWhere((element) => element.id == eventModel.id) !=
        -1;
    String? image = CategoryModel.categories
        .firstWhere(
          (element) => element.id == eventModel.categoryId,
          orElse: () => CategoryModel(id: 0, title: '', icon: Icons.close),
        )
        .image;
    return Container(
      height: 200,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: image == null
            ? null
            : DecorationImage(image: AssetImage(image), fit: BoxFit.fill),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 9),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Text(
              eventModel.date,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.mainColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 9),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  eventModel.title,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 24,
                  width: 24,
                  child: IconButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () async {
                      showDialog(
                        barrierDismissible: false,
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

                      String uid = FirebaseAuth.instance.currentUser!.uid;
                      if (isFav) {
                        await AuthService.removeFAvEvent(eventModel.id!, uid);
                      } else {
                        await AuthService.addFavEvent(eventModel, uid);
                      }
                      UserModel? user = await AuthService.getUserInfo(uid);
                      Provider.of<CurrantAuthProvider>(
                        context,
                        listen: false,
                      ).setCurrantUser(user!);
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border_rounded,
                      color: AppColors.mainColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
