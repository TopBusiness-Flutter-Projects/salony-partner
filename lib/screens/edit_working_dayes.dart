import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/businessLayer/baseRoute.dart';
import '../models/partnerUserModel.dart';
import '../widgets/bottomNavigationBar.dart';

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
  TimeOfDay selectedTime = TimeOfDay.now();
  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked_s = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        });

    if (picked_s != null && picked_s != selectedTime)
      setState(() {
        selectedTime = picked_s;
      });
    setState(() {});
  }

  TimeOfDay selectedTimeEnd = TimeOfDay.now();
  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked_s = await showTimePicker(
        context: context,
        initialTime: selectedTimeEnd,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        });

    if (picked_s != null && picked_s != selectedTimeEnd)
      setState(() {
        selectedTimeEnd = picked_s;
      });
    setState(() {});
  }

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
                  Scaffold.of(context).showBottomSheet((context) => Container(
                        height: MediaQuery.of(context).size.width,
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                  child: Text(userFromProfile
                                      .weekly_time[index].days!)),
                              // Text(
                              //   "${localizations.formatTimeOfDay(userFromProfile.weekly_time[index].open_hour!)} - ${localizations.formatTimeOfDay(userFromProfile.weekly_time[index].close_hour!)}",
                              // ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width / 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                          'من : ${localizations.formatTimeOfDay(selectedTime)}'),
                                      IconButton(
                                          onPressed: () {
                                            _selectEndTime(context);
                                            setState(() {});
                                          },
                                          icon: Icon(Icons.watch_later_rounded))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          'إلي : ${localizations.formatTimeOfDay(selectedTimeEnd)}'),
                                      IconButton(
                                          onPressed: () {
                                            _selectStartTime(context);
                                            setState(() {});
                                          },
                                          icon: Icon(Icons.watch_later_rounded))
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  MaterialButton(
                                    color: Color(0xFFFF6860),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BottomNavigationWidget(
                                                    a: widget.analytics,
                                                    o: widget.observer,
                                                  )));
                                      //nav to navigation bar and
                                    },
                                    child: Text('حفظ'),
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('إلغاء'),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ));
                },
                icon: Icon(CupertinoIcons.pencil_ellipsis_rectangle)),
          );
        },
      ),
    );
  }
}
