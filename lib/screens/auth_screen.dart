import 'package:flutter/material.dart';
import 'package:flutter_hua_yi_tang/widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Hero(
                  tag: 'logo tag',
                  child: Image.asset(
                    'lib/assets/images/logo.png',
                    width: 250,
                  ),
                ),
              ),
              Container(
                child: Text(
                  'ยินดีต้อนรับ',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'คุณสามารถเข้าสู่ระบบด้วยอีเมลที่สมัครไว้',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(
                height: 30,
              ),
              AuthForm(context),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
