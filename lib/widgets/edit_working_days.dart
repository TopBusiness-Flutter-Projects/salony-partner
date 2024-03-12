import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/partnerUserModel.dart';
import 'package:app/screens/reviewScreen.dart';
import 'package:app/screens/updateProfileScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'bottomNavigationBar.dart';

class WorkingDaysWidget extends BaseRoute {
  CurrentUser userFromProfile;
  int index;

  WorkingDaysWidget({a, o, required this.userFromProfile, required this.index})
      : super(a: a, o: o, r: 'ProfileScreen');
  @override
  _ProfileScreenState createState() =>
      new _ProfileScreenState(userFromProfile, index);
}

class _ProfileScreenState extends BaseRouteState {
  late GlobalKey<ScaffoldState> _scaffoldKey;
  CurrentUser userFromProfile;
  int index;

  _ProfileScreenState(this.userFromProfile, this.index) : super();
  TimeOfDay selectedTimeEnd = TimeOfDay.now();
  Future<void> _selectEndTime(BuildContext context2) async {
    final TimeOfDay? picked_s = await showTimePicker(
        context: context2,
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
  }

  TimeOfDay selectedTime = TimeOfDay.now();
  Future<void> _selectStartTime(BuildContext context2) async {
    final TimeOfDay? picked_s = await showTimePicker(
        context: context2,
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

  ///

  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);

    return Container(
      height: MediaQuery.of(context).size.width / 1.5,
      width: double.infinity,
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                child: Text(
              userFromProfile.weekly_time[index].days!,
              style: TextStyle(fontWeight: FontWeight.w600),
            )),
            // Text(
            //   "${localizations.formatTimeOfDay(userFromProfile.weekly_time[index].open_hour!)} - ${localizations.formatTimeOfDay(userFromProfile.weekly_time[index].close_hour!)}",
            // ),
            SizedBox(height: MediaQuery.of(context).size.width / 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    _selectStartTime(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'من : ${localizations.formatTimeOfDay(selectedTime)}',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Icon(Icons.watch_later_rounded)
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _selectEndTime(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'إلي : ${localizations.formatTimeOfDay(selectedTimeEnd)}',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Icon(Icons.watch_later_rounded)
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ToggleSwitch(
                minWidth: 90.0,
                cornerRadius: 20.0,
                activeBgColors: [
                  [Colors.green[800]!],
                  [Colors.red[800]!]
                ],
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                initialLabelIndex: userFromProfile.weekly_time[index].status,
                totalSwitches: 2,
                labels: ['مفتوح', 'مُغلق'],
                radiusStyle: true,
                onToggle: (index) {
                  status = index ?? 1;
                  print('switched to: $index');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MaterialButton(
                    color: Color(0xFFFF6860),
                    onPressed: () {
                      _editWorkingDaysTimes(
                        time_slot_id:
                            userFromProfile.weekly_time[index].time_slot_id!,
                      );
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
              ),
            )
          ],
        ),
      ),
    );
  }

  int status = 1;

  ///! edit working days
  _editWorkingDaysTimes({required int time_slot_id}) async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper
            ?.editWorkingDaysTimes(
                close_hour: formatTimeOfDay(selectedTimeEnd),
                open_hour: formatTimeOfDay(selectedTime),
                status: status,
                time_slot_id: time_slot_id)
            .then((result) {
          if (result != null) {
            if (result.status == "1") {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BottomNavigationWidget(
                            a: widget.analytics,
                            o: widget.observer,
                          )));
            } else {
              // _user?.review = null;
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print(
          "Exception - expertListScreen.dart - _getExperts():" + e.toString());
    }
  }

  String formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    final formatter = DateFormat.Hm(); // Use 'HH:mm' for 24-hour format

    return formatter.format(dateTime);
  }
}
