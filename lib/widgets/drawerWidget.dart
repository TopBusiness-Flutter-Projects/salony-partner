import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/screens/changePasswordScreen.dart';
import 'package:app/screens/couponListScreen.dart';
import 'package:app/screens/expertListScreen.dart';
import 'package:app/screens/galleryListScreen.dart';
import 'package:app/screens/helpAndSupportScreen.dart';
import 'package:app/screens/languageSelectionScreen.dart';
import 'package:app/screens/myWalletScreen.dart';
import 'package:app/screens/orderScreen.dart';
import 'package:app/screens/productListScreen.dart';
import 'package:app/screens/serviceListScreen.dart';
import 'package:app/screens/settingScreen.dart';
import 'package:app/screens/signInScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DrawerWidget extends BaseRoute {
  DrawerWidget({a, o}) : super(a: a, o: o, r: 'DrawerWidget');
  @override
  _DrawerWidgetState createState() => new _DrawerWidgetState();
}

class _DrawerWidgetState extends BaseRouteState {
  _DrawerWidgetState() : super();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 45, left: 08),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  child: global.user.vendor_logo == ""
                      ? CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage(
                            'assets/userImage.png',
                          ),
                        )
                      : CachedNetworkImage(
                          imageUrl: global.baseUrlForImage +
                              (global.user.vendor_logo ?? ''),
                          imageBuilder: (context, imageProvider) =>
                              CircleAvatar(
                            radius: 25,
                            backgroundImage: imageProvider,
                          ),
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                ),
                title: Text(
                  '${global.user.owner_name}',
                  style: Theme.of(context).primaryTextTheme.labelLarge,
                ),
                subtitle: Text(
                  global.user.vendor_phone != null
                      ? '${global.user.vendor_phone ?? ''}'
                      : '',
                  style: Theme.of(context).primaryTextTheme.headlineSmall,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.wallet,
                  color: Colors.white,
                  size: 22,
                ),
                title: Text(
                  AppLocalizations.of(context)!.lbl_my_wallet,
                  style: Theme.of(context).primaryTextTheme.labelLarge,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => MyWalletScreen(
                              a: widget.analytics,
                              o: widget.observer,
                            )),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(),
              child: ListTile(
                leading: Icon(
                  Icons.home_repair_service,
                  color: Colors.white,
                  size: 22,
                ),
                title: Text(
                  AppLocalizations.of(context)!.lbl_Add_service,
                  style: Theme.of(context).primaryTextTheme.labelLarge,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => ServiceListScreen(
                              a: widget.analytics,
                              o: widget.observer,
                            )),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(),
              child: ListTile(
                leading: Icon(
                  Icons.person_add,
                  color: Colors.white,
                  size: 22,
                ),
                title: Text(
                  AppLocalizations.of(context)!.lbl_add_expert,
                  style: Theme.of(context).primaryTextTheme.labelLarge,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => ExpertListScreen(
                              a: widget.analytics,
                              o: widget.observer,
                            )),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(),
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.tag,
                  color: Colors.white,
                  size: 22,
                ),
                title: Text(
                  AppLocalizations.of(context)!.lbl_Add_coupon,
                  style: Theme.of(context).primaryTextTheme.labelLarge,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => CouponListScreen(
                              a: widget.analytics,
                              o: widget.observer,
                            )),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(),
              child: ListTile(
                leading: Icon(
                  CupertinoIcons.photo_on_rectangle,
                  color: Colors.white,
                  size: 22,
                ),
                title: Text(
                  AppLocalizations.of(context)!.lbl_Add_gallery,
                  style: Theme.of(context).primaryTextTheme.labelLarge,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => GalleryListScreen(
                              a: widget.analytics,
                              o: widget.observer,
                            )),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(),
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.productHunt,
                  color: Colors.white,
                  size: 22,
                ),
                title: Text(
                  AppLocalizations.of(context)!.lbl_add_product,
                  style: Theme.of(context).primaryTextTheme.labelLarge,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => ProductListScreen(
                              a: widget.analytics,
                              o: widget.observer,
                            )),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(),
              child: ListTile(
                leading: Icon(
                  CupertinoIcons.option,
                  color: Colors.white,
                  size: 22,
                ),
                title: Text(
                  AppLocalizations.of(context)!.lbl_orders,
                  style: Theme.of(context).primaryTextTheme.labelLarge,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => OrderScreen(
                              a: widget.analytics,
                              o: widget.observer,
                            )),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(),
              child: ListTile(
                leading: Icon(
                  Icons.lock,
                  color: Colors.white,
                  size: 22,
                ),
                title: Text(
                  AppLocalizations.of(context)!.lbl_change_password,
                  style: Theme.of(context).primaryTextTheme.labelLarge,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => ChangePasswordScreen(
                              false,
                              a: widget.analytics,
                              o: widget.observer,
                            )),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(),
              child: ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 22,
                ),
                title: Text(
                  AppLocalizations.of(context)!.lbl_settings,
                  style: Theme.of(context).primaryTextTheme.labelLarge,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => SettingScreen(
                              a: widget.analytics,
                              o: widget.observer,
                            )),
                  );
                },
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(),
            //   child: ListTile(
            //     leading: Icon(
            //       FontAwesomeIcons.language,
            //       color: Colors.white,
            //       size: 22,
            //     ),
            //     title: Text(
            //       AppLocalizations.of(context)!.lbl_selet_language,
            //       style: Theme.of(context).primaryTextTheme.labelLarge,
            //     ),
            //     onTap: () {
            //       Navigator.of(context).push(
            //         MaterialPageRoute(
            //             builder: (context) => ChooseLanguageScreen(
            //                   a: widget.analytics,
            //                   o: widget.observer,
            //                 )),
            //       );
            //     },
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(),
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.circleQuestion,
                  color: Colors.white,
                  size: 22,
                ),
                title: Text(
                  AppLocalizations.of(context)!.lbl_help_and_support,
                  style: Theme.of(context).primaryTextTheme.labelLarge,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => HelpAndSupportScreen(
                              a: widget.analytics,
                              o: widget.observer,
                            )),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(),
              child: ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 22,
                ),
                title: Text(
                  AppLocalizations.of(context)!.lbl_sign_out,
                  style: Theme.of(context).primaryTextTheme.labelLarge,
                ),
                onTap: () {
                  _confirmationDialog();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isloading = true;

  @override
  void initState() {
    super.initState();
  }

  Future _confirmationDialog() async {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(
              AppLocalizations.of(context)!.lbl_sign_out,
            ),
            content: Text(AppLocalizations.of(context)!
                .txt_confirmation_message_for_sign_out),
            actions: [
              TextButton(
                child: Text(AppLocalizations.of(context)!.lbl_no),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: Text(AppLocalizations.of(context)!.lbl_yes),
                onPressed: () async {
                  global.sp.remove("currentUser");
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => SignInScreen(
                              a: widget.analytics,
                              o: widget.observer,
                            )),
                  );
                },
              )
            ],
          );
        });
  }
}
