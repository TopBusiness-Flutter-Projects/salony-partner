import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/screens/chooseSignUpSignInScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends BaseRoute {
  IntroScreen({a, o}) : super(a: a, o: o, r: 'IntroScreen');

  @override
  _IntroScreenState createState() => new _IntroScreenState();
}

class _IntroScreenState extends BaseRouteState {
  _IntroScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        exitAppDialog();
        return false;
      },
      child: Scaffold(
          body: SafeArea(
        child: Stack(children: [
          IntroductionScreen(
            dotsDecorator: DotsDecorator(
              activeSize: const Size(28, 12),
              size: const Size(17, 12),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0))),
              activeColor: Theme.of(context).primaryColor,
              color: Theme.of(context).primaryColorLight,
            ),
            showDoneButton: false,
            showNextButton: false,
            showSkipButton: false,
            pages: [
              PageViewModel(
                decoration: PageDecoration(
                  titleTextStyle: TextStyle(
                    fontFamily: 'cairo',
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                  titlePadding:
                      EdgeInsets.only(top: 60, bottom: 10, right: 35, left: 35),
                  contentMargin: EdgeInsets.only(bottom: 35),
                  bodyTextStyle: TextStyle(
                    fontFamily: 'cairo',
                    fontSize: 15,
                  ),
                ),
                image: Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Image.asset(
                    'assets/inreo_1.png',
                    fit: BoxFit.cover,
                  ),
                ),
                title: 'منصة الجمال الشامل',
                body:
                    ' يقدم هذا التطبيق خدمات شاملة في مجال الجمال والعناية بالبشرة والشعر، حيث يمكن للعملاء الاطلاع على مجموعة متنوعة من الخدمات وحجز مواعيدهم بسهولة عبر التطبيق، مع توفير معلومات شاملة حول المنتجات المستخدمة وخبرات العملاء السابقين.',
              ),
              PageViewModel(
                decoration: PageDecoration(
                  titleTextStyle: TextStyle(
                    fontFamily: 'cairo',
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                  titlePadding:
                      EdgeInsets.only(top: 60, bottom: 10, right: 35, left: 35),
                  contentMargin: EdgeInsets.only(bottom: 35),
                  bodyTextStyle: TextStyle(
                    fontFamily: 'cairo',
                    fontSize: 15,
                  ),
                ),
                image: Container(
                  padding: EdgeInsets.only(top: 40),
                  child: Image.asset(
                    'assets/inreo_2.png',
                    fit: BoxFit.cover,
                  ),
                ),
                title: 'أناقتك بين يديك',
                body:
                    ' يعتبر هذا التطبيق وجهة متكاملة للعملاء الباحثين عن تجارب جمال فريدة ومخصصة. من خلال قائمة واسعة من الخدمات والمنتجات، يمكن للعملاء تصميم جلساتهم الخاصة وحجز مواعيد استشارات شخصية للحصول على تجارب مخصصة تمامًا لاحتياجاتهم',
              ),
              PageViewModel(
                image: Container(
                  padding: EdgeInsets.only(top: 40),
                  child: Image.asset(
                    'assets/inreo_3.png',
                    fit: BoxFit.cover,
                  ),
                ),
                title: 'روعة الجمال في متناول يدك',
                body:
                    'يقدم هذا التطبيق لعملائه فرصة الاستمتاع بتجارب جمال فاخرة دون الحاجة إلى دفع أسعار مرتفعة. بفضل مجموعة متنوعة من الخدمات والعروض الترويجية، يمكن للعملاء الاستفادة من تجارب جمال مميزة تتناسب مع ميزانياتهم دون المساس بالجودة',
                decoration: PageDecoration(
                  bodyPadding: EdgeInsets.only(left: 28, right: 28),
                  titleTextStyle: TextStyle(
                    fontFamily: 'cairo',
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                  titlePadding:
                      EdgeInsets.only(top: 60, bottom: 10, right: 35, left: 35),
                  contentMargin: EdgeInsets.only(bottom: 35),
                  bodyTextStyle: TextStyle(
                    fontFamily: 'cairo',
                    fontSize: 15,
                  ),
                  footerPadding: EdgeInsets.only(top: 20),
                  imageFlex: 5,
                  bodyFlex: 6,
                  footerFlex: 2,
                  // footerFit: FlexFit.loose,
                ),
                footer: Container(
                  // height: 50,
                  // color: Colors.blue,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ChooseSignUpSignInScreen(
                                      a: widget.analytics,
                                      o: widget.observer,
                                    )));
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              AppLocalizations.of(context)!.btn_get_started,
                              style: TextStyle(
                                // wordSpacing: 10,
                                letterSpacing: 2,
                                fontFamily: 'cairo',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ]),
      )),
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
