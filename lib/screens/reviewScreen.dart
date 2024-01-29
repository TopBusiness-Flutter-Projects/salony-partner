import 'dart:io';

import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/models/businessLayer/global.dart' as global;
import 'package:app/models/reviewModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewScreen extends BaseRoute {
  final bool isForExpertReview;
  final List<Review> reviews;
  ReviewScreen(this.reviews, this.isForExpertReview, {a, o}) : super(a: a, o: o, r: 'ReviewScreen');
  @override
  _ReviewScreenState createState() => new _ReviewScreenState(this.reviews, this.isForExpertReview);
}

class _ReviewScreenState extends BaseRouteState {
  bool isForExpertReview;
  late List<Review> reviews;
  bool shopValue = false;
  late GlobalKey<ScaffoldState> _scaffoldKey;
  String? onlineStatus;
  bool isloading = true;

  _ReviewScreenState(this.reviews, this.isForExpertReview) : super();

  @override
  Widget build(BuildContext context) {
    return sc(
      WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop();
          return false;
        },
        child: Scaffold(
          key: _scaffoldKey,
          body: Stack(
            children: [
              Container(
                height: 100,
               
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).primaryColor,
                          BlendMode.screen,
                        ),
                        child: Image.asset(
                          'assets/banner.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: Platform.isAndroid ? EdgeInsets.only(bottom: 15, left: 10, top: 10) : EdgeInsets.only(bottom: 15, left: 10, top: 20),
                        child: Row(
                          children: [
                            Icon(
                              Icons.keyboard_arrow_left_outlined,
                              color: Colors.black,
                            ),
                            Text(
                              AppLocalizations.of(context)!.lbl_back,
                              style: TextStyle(color: Colors.black, fontSize: 17.5),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  ),
                  margin: EdgeInsets.only(top: 80),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 30, bottom: 10),
                          child: Text(AppLocalizations.of(context)!.lbl_reviews, style: Theme.of(context).primaryTextTheme.headline3),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                              itemCount: reviews.length,
                              itemBuilder: (BuildContext context, int index) {
                                return reviews[index].user != null
                                    ? Padding(
                                        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 3, top: 3),
                                        child: Card(
                                            shape: global.isRTL
                                                ? RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(25), bottomRight: Radius.circular(25)))
                                                : RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(25), bottomLeft: Radius.circular(25))),
                                            margin: EdgeInsets.only(top: 8),
                                            child: Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Row(
                                                children: [
                                                  reviews[index].user?.image != 'N/A'
                                                      ? CachedNetworkImage(
                                                          imageUrl: global.baseUrlForImage + reviews[index].user!.image!,
                                                          imageBuilder: (context, imageProvider) => CircleAvatar(radius: 25, backgroundImage: imageProvider),
                                                          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                                          errorWidget: (context, url, error) => CircleAvatar(
                                                            radius: 25,
                                                            child: Icon(Icons.person),
                                                          ),
                                                        )
                                                      : CircleAvatar(
                                                          radius: 26,
                                                          backgroundColor: Theme.of(context).primaryColor,
                                                          child: CircleAvatar(
                                                            radius: 25,
                                                            backgroundColor: Colors.white,
                                                            child: Icon(Icons.person),
                                                          ),
                                                        ),
                                                  Padding(
                                                    padding: global.isRTL ? EdgeInsets.only(right: 15) : EdgeInsets.only(left: 15),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text('${reviews[index].user?.name}'),
                                                        Row(
                                                          children: [
                                                            RatingBar.builder(
                                                              initialRating: reviews[index].rating!,
                                                              minRating: 0,
                                                              direction: Axis.horizontal,
                                                              allowHalfRating: true,
                                                              itemCount: 5,
                                                              itemSize: 12,
                                                              itemPadding: EdgeInsets.symmetric(horizontal: 0),
                                                              itemBuilder: (context, _) => Icon(
                                                                Icons.star,
                                                                color: Colors.amber,
                                                              ),
                                                              ignoreGestures: true,
                                                              updateOnDrag: false,
                                                              onRatingUpdate: (rating) {
                                                               
                                                              },
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets.only(left: 3),
                                                              child: Text(
                                                                '${reviews[index].rating}',
                                                                style: Theme.of(context).primaryTextTheme.subtitle1,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        reviews[index].descriptionForPartner != null || reviews[index].descriptionForExpert != null
                                                            ? isForExpertReview
                                                                ? Text(
                                                                    '${reviews[index].descriptionForExpert}',
                                                                    style: Theme.of(context).primaryTextTheme.subtitle1,
                                                                  )
                                                                : Text(
                                                                    '${reviews[index].descriptionForPartner}',
                                                                    style: Theme.of(context).primaryTextTheme.subtitle1,
                                                                  )
                                                            : SizedBox()
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      )
                                    : SizedBox();
                              }),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
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
    if (global.user.online_status != null) {
      if (global.user.online_status == "ON") {
        setState(() {
          shopValue = true;
        });
      } else {
        setState(() {
          shopValue = false;
        });
      }
    }
  }
}
