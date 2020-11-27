import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hua_yi_tang/helper/auth_helper.dart';
import 'package:provider/provider.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const routeName = '/forget-password-screen';

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  FocusNode _emailFocusNode;
  String _email;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _emailController = new TextEditingController();

  void _errorSnackBar(String message) {
    _scaffoldKey.currentState.hideCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        'Error : $message',
        style: TextStyle(fontFamily: 'Supermarket'),
      ),
      backgroundColor: Theme.of(context).errorColor,
      duration: Duration(seconds: 5),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 30, top: 40),
                      child: Hero(
                        tag: 'logo tag',
                        child: Image.asset(
                          'lib/assets/images/logo.png',
                          width: 150,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        'ลืมรหัสผ่าน',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'กรอกอีเมลขอคุณ หลังจากนั้นจะมีข้อความส่งไปให้เปลี่ยนรหัสผ่าน',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'อีเมล',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          onChanged: (value) {
                            _email = value;
                          },
                          validator: (value) =>
                              !EmailValidator.validate(value, true)
                                  ? 'โปรดกรอกอีเมลที่ถูกต้อง'
                                  : null,
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      height: 50,
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: () async {
                          final isValid = _formKey.currentState.validate();
                          if (!isValid) {
                            _errorSnackBar('โปรดกรอกอีเมลที่ถูกต้อง');
                            return;
                          }
                          try {
                            setState(() {
                              _isLoading = true;
                            });
                            await AuthProvider.resetPassword(_email);
                            _emailController.clear();
                            print('Send reset password request to $_email');
                          } catch (err) {
                            _errorSnackBar(
                                'เกิดข้อผิดพลาด โปรดลองอีกครั้งภายหลัง');
                            print(err);
                          }
                          setState(() {
                            _isLoading = false;
                          });
                        },
                        child: _isLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Text(
                                'เปลี่ยนรหัสผ่าน',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                iconSize: 30,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
