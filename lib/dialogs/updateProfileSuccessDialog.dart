import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/widgets/bottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpdateProfileSuccessDialog extends BaseRoute {
  UpdateProfileSuccessDialog({a, o})
      : super(a: a, o: o, r: 'UpdateProfileSuccessDialog');
  @override
  _UpdateProfileSuccessDialogState createState() =>
      new _UpdateProfileSuccessDialogState();
}

class _UpdateProfileSuccessDialogState extends BaseRouteState {
  bool isloading = true;

  _UpdateProfileSuccessDialogState() : super();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.only(left: 0, right: 0),
      content: Padding(
        padding: const EdgeInsets.only(top: 70),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 28,
              child: Icon(
                Icons.check,
                size: 40,
                color: Colors.white,
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!
                          .txt_successfully_changed_your_profile,
                      style: Theme.of(context).primaryTextTheme.headline6,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 70),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.only(top: 15, bottom: 15))),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BottomNavigationWidget(
                              a: widget.analytics,
                              o: widget.observer,
                            )));
                  },
                  child: Text('تأكيد'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }
}
