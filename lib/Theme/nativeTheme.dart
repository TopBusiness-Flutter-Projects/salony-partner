import 'package:flutter/material.dart';

Map<int, Color> color = {
  50: Color.fromRGBO(83, 174, 219, .1),
  100: Color.fromRGBO(83, 174, 219, .2),
  200: Color.fromRGBO(83, 174, 219, .3),
  300: Color.fromRGBO(83, 174, 219, .4),
  400: Color.fromRGBO(83, 174, 219, .5),
  500: Color.fromRGBO(83, 174, 219, .6),
  600: Color.fromRGBO(83, 174, 219, .7),
  700: Color.fromRGBO(83, 174, 219, .8),
  800: Color.fromRGBO(83, 174, 219, .9),
  900: Color.fromRGBO(83, 174, 219, 1),
};
ThemeData nativeTheme() {
  return ThemeData(
      primaryColor: const Color.fromARGB(255, 83, 174,
          219), //partner app old primary color: #FA692C ,new updated color #ff6860 (02-10-2021)
      // primaryColorLight: Color.fromRGBO(255, 166, 146, .6), // Color(0xFFFFA692),
      primaryColorLight: Color.fromRGBO(83, 174, 219, .7),
      primaryColorDark: Color.fromRGBO(83, 174, 219, 1),
      primarySwatch: MaterialColor(0xFFFF6860, color),
      primaryIconTheme: IconThemeData(color: Colors.white),
      iconTheme: IconThemeData(color: Color.fromRGBO(83, 174, 219, 1)),
      cardColor: Color(0xFFF8F1F7),
      primaryTextTheme: TextTheme(
        labelLarge: TextStyle(color: Colors.white, fontSize: 17),
        displayLarge:
            TextStyle(fontSize: 15, color: Color.fromRGBO(83, 174, 219, 1)),
        displayMedium: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontFamily: 'cairo',
            fontWeight: FontWeight.w500,
            letterSpacing: 0.32), //listtile subtitle white
        displaySmall: TextStyle(
            fontSize: 21,
            fontFamily: 'cairo',
            color: Colors.black,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.5), // intro
        headlineMedium: TextStyle(
            fontSize: 16,
            fontFamily: 'cairo',
            fontWeight: FontWeight.w600,
            color: Colors.black), //service
        headlineSmall: TextStyle(
            fontSize: 13.5,
            fontFamily: 'cairo',
            color: Colors.white.withOpacity(0.6),
            letterSpacing: 0.32,
            fontWeight: FontWeight.w300), // listtile white title
        titleLarge: TextStyle(
            fontSize: 16,
            fontFamily: 'cairo',
            fontWeight: FontWeight.bold,
            color: Colors.black), //list's title
        titleMedium: TextStyle(
            fontSize: 12.5,
            fontFamily: 'cairo',
            color: Colors.grey[600],
            fontWeight: FontWeight.w400), // textform label, listtile title
        titleSmall: TextStyle(
            fontSize: 14,
            fontFamily: 'cairo',
            fontWeight: FontWeight.w600,
            color: Colors.black.withOpacity(0.6)), //listtile subtitle
        labelSmall: TextStyle(
            fontSize: 31,
            fontFamily: 'cairo',
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.7)),
        bodySmall: TextStyle(
            color: Colors.black54,
            fontFamily: 'cairo',
            fontSize: 17,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.32), // drawer

        bodyLarge: TextStyle(
            color: Colors.white70,
            fontSize: 10,
            fontFamily: 'cairo',
            fontWeight: FontWeight.w400),
        bodyMedium: TextStyle(
            color: Colors.black45,
            fontSize: 10,
            fontFamily: 'cairo',
            fontWeight: FontWeight.w400),
      ), //AppBar Text field

      scaffoldBackgroundColor: Colors.white,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Color.fromRGBO(83, 174, 219, 1),
      ),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
        padding:
            MaterialStateProperty.all(EdgeInsets.only(top: 10, bottom: 10)),
        backgroundColor:
            MaterialStateProperty.all(Color.fromRGBO(83, 174, 219, 1)),
        shadowColor: MaterialStateProperty.all(Colors.white),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        )),
        textStyle: MaterialStateProperty.all(TextStyle(
            fontFamily: 'cairo',
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w600)),
      )),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
        side: MaterialStateProperty.all(
            BorderSide(color: Color.fromRGBO(83, 174, 219, 1), width: 1.5)),
        textStyle: MaterialStateProperty.all(TextStyle(
            fontSize: 16,
            fontFamily: 'cairo',
            color: Color.fromRGBO(83, 174, 219, 1),
            fontWeight: FontWeight.w400)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        )),
      )),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Colors.grey[100],
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'cairo',
            color: Color.fromRGBO(83, 174, 219, 1)),
      ),
      //elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(elevation: 0.5)),
      fontFamily: 'cairo',
      dividerColor: Colors.grey[300],
      buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.primary,
        height: 50,
        buttonColor: Color.fromRGBO(83, 174, 219, 1),
        focusColor: Color.fromRGBO(83, 174, 219, 1),
        highlightColor: Color.fromRGBO(83, 174, 219, 1),
        hoverColor: Color.fromRGBO(83, 174, 219, 1),
        splashColor: Color.fromRGBO(83, 174, 219, 1),
        disabledColor: Colors.grey,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.all(new Radius.circular(10.0))),
      ),
      cardTheme: CardTheme(
        elevation: 0.5,
        margin: EdgeInsets.all(0),
        color: Colors.grey[100],
        shadowColor: Colors.grey[200],
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          fontSize: 14, fontFamily: 'cairo',
          color: Colors.grey[400],
          // color: Color(0xFF707173),
          fontWeight: FontWeight.w400,
        ),
        counterStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(width: 0.2, color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Color(0xFF898A8D).withOpacity(0.2)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(83, 174, 219, 1)),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        filled: true,
        fillColor: Colors.white,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      appBarTheme: AppBarTheme(
        color: Colors.grey[100],
        elevation: 0,
        actionsIconTheme:
            IconThemeData(color: Color.fromRGBO(83, 174, 219, 1), size: 30),
        iconTheme:
            IconThemeData(color: Color.fromRGBO(83, 174, 219, 1), size: 24),
      ),
      useMaterial3: false,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            padding: MaterialStateProperty.all(
              EdgeInsets.only(top: 15, bottom: 15),
            ),
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shadowColor: MaterialStateProperty.all(Colors.white),
            overlayColor: MaterialStateProperty.all(Colors.white),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            textStyle: MaterialStateProperty.all(TextStyle(
                fontSize: 16,
                fontFamily: 'cairo',
                color: Colors.grey[800],
                fontWeight: FontWeight.w600))),
      ),
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all(Colors.white),
        fillColor: MaterialStateProperty.all(Color.fromRGBO(83, 174, 219, 1)),
      ));
}
