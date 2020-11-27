import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_hua_yi_tang/helper/debug_helper.dart';
import 'package:flutter_hua_yi_tang/screens/choose_language_screen.dart';
import 'package:flutter_hua_yi_tang/screens/forget_password_screen.dart';
import 'package:flutter_hua_yi_tang/screens/frequently_asked_question_screen.dart';
import 'package:flutter_hua_yi_tang/screens/help_screen.dart';
import 'package:flutter_hua_yi_tang/screens/setting_screen.dart';
import 'package:flutter_hua_yi_tang/screens/state/checking_state_screen.dart';
import 'package:flutter_hua_yi_tang/screens/toggle_faceid_screen.dart';
import 'package:flutter_hua_yi_tang/screens/toggle_notification_screen.dart';
import 'package:provider/provider.dart';

import './assets/style/style.dart';
import './helper/auth_helper.dart';
import 'helper/custom_route.dart';

import './screens/add_diagnosis_explanation_screen.dart';
import './screens/add_diagnosis_screen.dart';
import './screens/auth_screen.dart';
import './screens/contact_us_screen.dart';
import 'screens/state/done_state_screen.dart';
import './screens/main_screen.dart';
import './screens/medicine_explanation_screen.dart';
import 'screens/personal_info_screen.dart';
import './screens/signup_screen.dart';
import 'screens/state/waiting_for_dianosis_screen.dart';
import 'screens/state/waiting_for_payment_screen.dart';
import './screens/edit_personal_credential_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (DebugHelper.globalDebug) DebugHelper.dataGenerator();
    return MultiProvider(
        providers: [
          //Use FireBase Stream instead
          ChangeNotifierProvider(
            create: (context) => AuthProvider(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: 'Supermarket',
            appBarTheme: AppBarTheme(
              color: Colors.white,
              iconTheme: IconThemeData(color: Colors.black),
              textTheme: TextTheme().copyWith(
                headline6: TextStyle(
                  fontFamily: defalutFont,
                  color: Colors.black,
                  fontSize: 26,
                ),
              ),
              elevation: 10,
            ),
            primaryColor: ownColors['Primary'],
            backgroundColor: Colors.white,
            accentColor: ownColors['Secondary'],
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.android: CustomPageTransitionBuilder(),
              TargetPlatform.iOS: CustomPageTransitionBuilder(),
            }),
            buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: ownColors['Primary'],
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.onAuthStateChanged,
            builder: (context, streamSnapshot) {
              if (streamSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (streamSnapshot.hasData) {
                print('isVer ${streamSnapshot.data.isEmailVerified}');
                return MainScreen();
              }
              print('dont have data');
              return AuthScreen();
            },
          ),
          routes: {
            MainScreen.routeName: (context) => MainScreen(),
            SignUpScreen.routeName: (context) => SignUpScreen(),
            ForgetPasswordScreen.routeName: (context) => ForgetPasswordScreen(),
            AddDiagnosisScreen.routeName: (context) => AddDiagnosisScreen(),
            ContactUsScreen.routeName: (context) => ContactUsScreen(),
            MedicineExplanationScreen.routeName: (context) =>
                MedicineExplanationScreen(),
            /**Conditional Screen */
            WaitingForDiagnosisScreen.routeName: (context) =>
                WaitingForDiagnosisScreen(),
            WaitingForPayment.routeName: (context) => WaitingForPayment(),
            CheckingStateScreen.routeName: (context) => CheckingStateScreen(),
            DoneStateScreen.routeName: (context) => DoneStateScreen(),
            /**PersonalInfo Screen */
            PersonalInfoScreen.routeName: (context) => PersonalInfoScreen(),
            EditPersonalCredentialScreen.routeName: (context) =>
                EditPersonalCredentialScreen(),
            /**Help Screen */
            HelpScreen.routeName: (context) => HelpScreen(),
            AddDiagnosisExplanationScreen.routeName: (context) =>
                AddDiagnosisExplanationScreen(),
            FrequentlyAskedQuestion.routeName: (context) =>
                FrequentlyAskedQuestion(),
            /**Setting Screen */
            SettingScreen.routeName: (context) => SettingScreen(),
            ToggleFaceIDScreen.routeName: (context) => ToggleFaceIDScreen(),
            ChooseLanguageScreen.routeName: (context) => ChooseLanguageScreen(),
            /**Notification Screen */
            ToggleNotificationScreen.routeName: (context) =>
                ToggleNotificationScreen(),
          },
        ));
  }
}
