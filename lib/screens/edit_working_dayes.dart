import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/models/businessLayer/global.dart' as global;

import '../models/businessLayer/baseRoute.dart';
import '../models/partnerUserModel.dart';
import '../widgets/edit_working_days.dart';

class EditWorkingDayes extends BaseRoute {
  final CurrentUser userFromProfile;
  EditWorkingDayes(this.userFromProfile, {a, o})
      : super(a: a, o: o, r: 'EditWorkingDayes');
  @override
  _EditWorkingDayesState createState() =>
      new _EditWorkingDayesState(this.userFromProfile);
}

class _EditWorkingDayesState extends BaseRouteState {
  CurrentUser userFromProfile;

  _EditWorkingDayesState(this.userFromProfile) : super();

  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تعديل مواقيت العمل',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: userFromProfile.weekly_time.length,
        itemBuilder: (context, index) {
          return ListTile(
            trailing: Text(userFromProfile.weekly_time[index].days!),
            title: Text(
              "${localizations.formatTimeOfDay(userFromProfile.weekly_time[index].open_hour!)} - ${localizations.formatTimeOfDay(userFromProfile.weekly_time[index].close_hour!)}",
            ),
            leading: IconButton(
                onPressed: () {
                  Scaffold.of(context).showBottomSheet(
                      enableDrag: true,
                      backgroundColor: Colors.blueGrey.shade100,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12),
                        topLeft: Radius.circular(12),
                      )), (BuildContext context) {
                    return WorkingDaysWidget(
                      userFromProfile: userFromProfile,
                      a: widget.analytics,
                      o: widget.observer,
                      index: index,
                    );
                  });
                },
                icon: Icon(CupertinoIcons.pencil_ellipsis_rectangle)),
          );
        },
      ),
    );
  }
}
