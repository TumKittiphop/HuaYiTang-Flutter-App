import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hua_yi_tang/helper/auth_helper.dart';
import 'package:flutter_hua_yi_tang/screens/forget_password_screen.dart';
import 'package:provider/provider.dart';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:flutter_hua_yi_tang/screens/signup_screen.dart';

class AuthForm extends StatefulWidget {
  final BuildContext parentContext;
  AuthForm(this.parentContext);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  FocusNode _passwordFocusNode, _emailFocusNode;
  String _email;
  String _password;
  bool _isLoading = false;
  bool _isHidden = true;
  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
  }

  void _tryLogin(BuildContext ctx) async {
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      FocusScope.of(context).requestFocus(new FocusNode());
      setState(() {
        _isLoading = true;
      });
      try {
        await AuthProvider.login(_email.trim(), _password);
      } on PlatformException catch (error) {
        var message = 'Email or password incorrect';
        if (error.message != null) {
          print(error.message);
        }
        _errorSnackBar(ctx, message);
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        print(error);
        _errorSnackBar(ctx, error.toString());
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  /// Show error SnackBar
  void _errorSnackBar(BuildContext ctx, String message) {
    Scaffold.of(ctx).hideCurrentSnackBar();
    Scaffold.of(ctx).showSnackBar(SnackBar(
      content: Text(
        'Error : $message',
        style: TextStyle(fontFamily: 'Supermarket'),
      ),
      backgroundColor: Theme.of(context).errorColor,
      duration: Duration(seconds: 2),
    ));
  }

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                focusNode: _emailFocusNode,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                enableSuggestions: false,
                decoration: InputDecoration(
                  hintText: 'อีเมล',
                  prefixIcon: Icon(Icons.person),
                  focusColor: Theme.of(context).primaryColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
                onEditingComplete: () => _passwordFocusNode.requestFocus(),
                onChanged: (value) {
                  _email = value;
                },
                validator: (value) => !EmailValidator.validate(value, true)
                    ? 'โปรดกรอกอีเมลที่ถูกต้อง'
                    : null,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                focusNode: _passwordFocusNode,
                obscureText: _isHidden,
                autocorrect: false,
                enableSuggestions: false,
                decoration: InputDecoration(
                  hintText: 'รหัสผ่าน',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: _isHidden
                      ? GestureDetector(
                          onTap: _toggleVisibility,
                          child: Icon(Icons.visibility),
                        )
                      : GestureDetector(
                          onTap: _toggleVisibility,
                          child: Icon(Icons.visibility_off),
                        ),
                  focusColor: Theme.of(context).primaryColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
                onEditingComplete: () => _tryLogin(context),
                onChanged: (value) {
                  _password = value;
                },
                validator: (value) {
                  if (value.isEmpty || value.length < 6) {
                    return 'รหัสผ่านต้องมีอย่างน้อย 6 ตัว';
                  }
                  return null;
                },
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                alignment: Alignment.centerRight,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'ลืมรหัสผ่าน',
                        style: TextStyle(
                          fontFamily: 'Supermarket',
                          fontSize: 16,
                          color: Colors.indigo,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context)
                                .pushNamed(ForgetPasswordScreen.routeName);
                          },
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 200,
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : RaisedButton(
                        onPressed: () {
                          _tryLogin(context);
                        },
                        child: Text(
                          'ลงชื่อเข้าใช้งาน',
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
              ),
              SizedBox(
                height: 20,
              ),
              //if (!_isLoading)
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'ยังไม่มีบัญชีใช่หรือไม่? ',
                      style: TextStyle(
                        fontFamily: 'Supermarket',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'สมัครสมาชิกที่นี่',
                      style: TextStyle(
                        fontFamily: 'Supermarket',
                        fontSize: 16,
                        color: Colors.indigo,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          Navigator.of(context)
                              .pushNamed(SignUpScreen.routeName);
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
