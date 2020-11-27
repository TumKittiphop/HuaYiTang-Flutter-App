import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hua_yi_tang/helper/auth_helper.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/sign-in-screen';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isPasswordHidden = true,
      _isValidationPasswordHidden = true,
      _isLoading = false;
  FocusNode _emailFocusNode,
      _passwordFocusNode,
      _passwordValidationFocusNode,
      _fullNameFocusNode,
      _addressFocusNode;
  String _email;
  String _password;
  String _passwordValidation;
  String _fullName;
  String _gender;
  String _address;
  DateTime _selectedBirthDate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _passwordValidationFocusNode = FocusNode();
    _fullNameFocusNode = FocusNode();
    _addressFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _passwordValidationFocusNode.dispose();
    _fullNameFocusNode.dispose();
    _addressFocusNode.dispose();
  }

  void _submitSingUpForm() async {
    //String _emailTrim = _email.trim();
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      _errorSnackBar('โปรดกรอกข้อมูลให้ครบถ้วน');
      return;
    }
    if (_gender == null) {
      _errorSnackBar('โปรดระบุเพศ');
      return;
    }
    if (_selectedBirthDate == null) {
      _errorSnackBar('โปรดระบุวันเกิด');
      return;
    }
    if (_password != _passwordValidation) {
      _errorSnackBar('รหัสผ่านที่ยืนยันไม่ตรงกัน');
      return;
    }
    if (_password.contains(' ')) {
      _errorSnackBar('รหัสผ่านไม่สามารถมีช่องว่างได้');
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      await AuthProvider.signUpWithEmail(
        _email.trim(),
        _password.trim(),
        _fullName.trim(),
        Timestamp.fromDate(_selectedBirthDate),
        _gender,
        _address.trim(),
      );
      Navigator.of(context).pop();
    } on PlatformException catch (error) {
      var message = 'โปรดกรอกข้อมูลให้ครบถ้วน';
      if (error.message != null) {
        message = error.message;
      }
      _errorSnackBar(message);
    } catch (error) {
      print(error);
      _errorSnackBar(error.toString());
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    if (Platform.isIOS) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext builder) {
            return Container(
              height: MediaQuery.of(context).copyWith().size.height * 0.2,
              color: Colors.white,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (picked) {
                  if (picked != null && picked != _selectedBirthDate)
                    //print(picked);
                    setState(() {
                      _selectedBirthDate = picked;
                    });
                },
                initialDateTime: _selectedBirthDate,
                minimumYear: DateTime.now().year - 80,
                maximumYear: DateTime.now().year,
              ),
            );
          });
    } else {
      final DateTime selectedDate = await showDatePicker(
        context: context,
        confirmText: 'ยืนยัน',
        cancelText: 'ยกเลิก',
        helpText: 'วัน เดือน ปีเกิด',
        fieldLabelText: 'วันเกิด',
        errorInvalidText: 'ข้อมูลไม่ถูกต้อง',
        errorFormatText: 'ข้อมูลไม่ถูกต้อง',
        initialDate:
            _selectedBirthDate == null ? DateTime.now() : _selectedBirthDate,
        firstDate: DateTime(DateTime.now().year - 80),
        lastDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.year,
      );
      if (selectedDate != null && selectedDate != _selectedBirthDate)
        setState(() {
          //print(_selectedBirthDate);
          _selectedBirthDate = selectedDate;
        });
    }
  }

  /// Show error SnackBar
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
    final double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 30,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  SizedBox(height: 60),
                  Container(
                    child: Text(
                      'เริ่มต้นการสมัครสมาชิก',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'คุณสามารถสมัครสามาชิกได้โดยไม่เสียค่าใช่จ่าย',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: TextFormField(
                      focusNode: _fullNameFocusNode,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'ชื่อ นามสกุล',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onEditingComplete: () => _emailFocusNode.requestFocus(),
                      onChanged: (value) {
                        _fullName = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'โปรดระบุชื่อ นามสกุล';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: TextFormField(
                      focusNode: _emailFocusNode,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'อีเมล',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onEditingComplete: () =>
                          _passwordFocusNode.requestFocus(),
                      onChanged: (value) {
                        _email = value;
                      },
                      validator: (value) =>
                          !EmailValidator.validate(value, true)
                              ? 'โปรดกรอกอีเมลที่ถูกต้อง'
                              : null,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: TextFormField(
                      focusNode: _passwordFocusNode,
                      obscureText: _isPasswordHidden,
                      decoration: InputDecoration(
                        hintText: 'รหัสผ่าน',
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: _isPasswordHidden
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isPasswordHidden = !_isPasswordHidden;
                                  });
                                },
                                child: Icon(Icons.visibility),
                              )
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isPasswordHidden = !_isPasswordHidden;
                                  });
                                },
                                child: Icon(Icons.visibility_off),
                              ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onEditingComplete: () =>
                          _passwordValidationFocusNode.requestFocus(),
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
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: TextFormField(
                      focusNode: _passwordValidationFocusNode,
                      obscureText: _isValidationPasswordHidden,
                      decoration: InputDecoration(
                        hintText: 'ยืนยันรหัสผ่าน',
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: _isValidationPasswordHidden
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isValidationPasswordHidden =
                                        !_isValidationPasswordHidden;
                                  });
                                },
                                child: Icon(Icons.visibility),
                              )
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isValidationPasswordHidden =
                                        !_isValidationPasswordHidden;
                                  });
                                },
                                child: Icon(Icons.visibility_off),
                              ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onEditingComplete: () => _addressFocusNode.requestFocus(),
                      onChanged: (value) {
                        _passwordValidation = value;
                      },
                      validator: (value) {
                        if (value.isEmpty || value.length < 6) {
                          return 'รหัสผ่านต้องมีอย่างน้อย 6 ตัว';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: TextFormField(
                      focusNode: _addressFocusNode,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.home),
                        hintText: 'ที่อยู่',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onEditingComplete: () => _addressFocusNode.unfocus(),
                      onChanged: (value) {
                        _address = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'โปรดระบุที่อยู่';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            width: _screenWidth * 0.59,
                            alignment: Alignment.center,
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SizedBox(width: 5),
                                Container(
                                  child: Text(
                                    'วันเกิด',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: _screenWidth * 0.59 * 0.5,
                                  child: Text(
                                    _selectedBirthDate != null
                                        ? DateFormat.yMd()
                                            .format(_selectedBirthDate)
                                        : "",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Icon(Icons.calendar_today),
                                ),
                                SizedBox(width: 5),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          height: 50,
                          width: _screenWidth * 0.3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  'เพศ',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              GenderPicker(
                                chooseGender: (String newValue) {
                                  setState(() {
                                    _gender = newValue;
                                  });
                                },
                                gender: _gender,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 100),
                    height: 50,
                    width: _screenWidth * 0.5,
                    child: RaisedButton(
                      onPressed: _submitSingUpForm,
                      child: _isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Text(
                              'ยืนยันการสมัครสมาชิก',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GenderPicker extends StatefulWidget {
  final Function chooseGender;
  final String gender;
  GenderPicker({
    Key key,
    this.chooseGender,
    this.gender,
  }) : super(key: key);

  @override
  _GenderPickerState createState() => _GenderPickerState();
}

class _GenderPickerState extends State<GenderPicker> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.gender,
      icon: Icon(Icons.arrow_downward),
      iconSize: 20,
      elevation: 10,
      style: TextStyle(color: Theme.of(context).primaryColor),
      underline: Container(
        height: 2,
        color: Theme.of(context).primaryColor,
      ),
      onChanged: widget.chooseGender,
      items: <String>['ชาย', 'หญิง', 'อื่นๆ']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'Supermarket',
              fontSize: 16,
            ),
          ),
        );
      }).toList(),
    );
  }
}
