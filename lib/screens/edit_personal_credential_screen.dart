import 'package:flutter/material.dart';
import 'package:flutter_hua_yi_tang/helper/auth_helper.dart';
import 'package:flutter_hua_yi_tang/helper/map_of_detail.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class EditPersonalCredentialScreen extends StatefulWidget {
  static const routeName = '/edit-personal-credential-screen';
  @override
  _EditPersonalCredentialScreenState createState() =>
      _EditPersonalCredentialScreenState();
}

class _EditPersonalCredentialScreenState
    extends State<EditPersonalCredentialScreen> {
  final _formKey = GlobalKey<FormState>();
  String _fullName;
  String _address;
  bool _isInit = false;
  bool _isLoading = false;
  Future<bool> _confirmDialog(BuildContext ctx) async {
    return Alert(
      context: ctx,
      type: AlertType.info,
      title: "ยืนยันการแก้ไขข้อมูล",
      closeFunction: () {},
      buttons: [
        DialogButton(
          child: Text(
            "ยกเลิก",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.of(ctx).pop(false),
          color: Colors.grey,
        ),
        DialogButton(
          child: Text(
            "ยืนยัน",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.of(ctx).pop(true),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }

  void _submitEditing(BuildContext ctx) async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      _errorSnackBar(ctx, 'โปรดกรอกข้อมูลให้ครบถ้วน');
      return;
    }
    try {
      final result = await _confirmDialog(ctx);
      if (result != true) return;
      setState(() {
        _isLoading = true;
      });
      await AuthProvider.editCredential(
        _fullName,
        _address,
      );

      Navigator.of(ctx).pop();
    } catch (error) {
      _errorSnackBar(ctx, error.toString());
    }
    setState(() {
      _isLoading = false;
    });
  }

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

  Widget _textFieldContainer(String initValue, String labelText,
      Function handlerFn, TextInputType keyboardType) {
    return Container(
      margin: EdgeInsets.all(8),
      child: TextFormField(
        initialValue: initValue,
        keyboardType: keyboardType,
        style: TextStyle(fontSize: 18),
        maxLines: keyboardType == TextInputType.multiline ? 3 : 1,
        onChanged: handlerFn,
        decoration: InputDecoration(
          labelText: credentialTranslator[labelText],
          labelStyle: TextStyle(fontSize: 18),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'โปรดกรอกข้อมูลให้ครบถ้วน';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    if (!_isInit) {
      _fullName = args['fullName'];
      _address = args['address'];
      _isInit = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขข้อมูลส่วนตัว'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    _textFieldContainer(
                      args['fullName'],
                      'fullName',
                      (value) {
                        _fullName = value;
                      },
                      null,
                    ),
                    _textFieldContainer(
                      args['address'],
                      'address',
                      (value) {
                        _address = value;
                      },
                      TextInputType.multiline,
                    ),
                  ],
                ),
              ),
            ),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                    width: double.infinity,
                    child: RaisedButton(
                      child: Text('ยืนยันการแก้ไข'),
                      onPressed: () {
                        _submitEditing(context);
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
