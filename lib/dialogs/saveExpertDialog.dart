import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/screens/expertListScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SaveExpertDialog extends BaseRoute {
  SaveExpertDialog({a, o}) : super(a: a, o: o, r: 'SaveExpertDialog');
  @override
  _SaveExpertDialogState createState() => new _SaveExpertDialogState();
}

class _SaveExpertDialogState extends BaseRouteState {
  bool isloading = true;

  _SaveExpertDialogState() : super();

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
                          .txt_successfully_add_your_new_expert,
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
                        builder: (context) => ExpertListScreen(
                              a: widget.analytics,
                              o: widget.observer,
                              screenId: 1,
                            )));
                  },
                  child: Text(AppLocalizations.of(context)!.lbl_ok),
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
