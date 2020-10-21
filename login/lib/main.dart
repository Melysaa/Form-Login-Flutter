import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Form Login';
    

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        backgroundColor: Colors.grey[250],
        appBar: AppBar(
          title: Center(child: Text(appTitle)),
        ),
        body: MyCustomForm (
          )
          ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  String nama ="nama", sandi ="sandi";
  final kontrollernama = TextEditingController();
  final kontrollersandi = TextEditingController();
 

  login() async {
    // SERVER LOGIN API URL
    var url = 'http://192.168.43.123/projectapi/login.php';
    // POST KE SISTEM
    var response =
        await http.post(url, body: {'nama': nama, 'sandi': sandi});

    // Getting Server response into variable.
    var message = jsonDecode(response.body);
    if (message == 'login berhasil') {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Alhamdulillah Login Berhasil"),
          );
        },
      );
    } else if (message == "login gagal") {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Maaf anda tidak diizinkan masuk"),
          );
        },
      );
    } else {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Response Aneh"),
          );
        },
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: kontrollernama,
            decoration: const InputDecoration(hintText: "Username"),
            
            validator: (value) {
              if (value.isEmpty) {
                return 'Mohon Lengkapi Form Terlebih Dahulu';
              }
              return null;
            },
          ),
          //ini untuk password
          TextFormField(
            controller: kontrollersandi,
            obscureText: true,
            decoration: const InputDecoration(hintText: "Password"),
            validator: (value) {
              if (value.isEmpty) {
                return 'Mohon Lengkapi Form Terlebih Dahulu';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
            child: RaisedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false
                // otherwise.
                // if (_formKey.currentState.validate()) {
                //   // If the form is valid, display a Snackbar.
                //   Scaffold.of(context)
                //       .showSnackBar(SnackBar(content: Text('Processing Data')));
                // }
                    nama = kontrollernama.text.trim();
                    sandi = kontrollersandi.text.trim();
                    login();
                  },
                  child: Text('Login'),
                ),
              )),
        ],
      ),
    );
  }
}