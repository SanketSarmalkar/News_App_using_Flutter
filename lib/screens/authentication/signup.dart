import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/services/auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String error = "";
  String email = "";
  String password = "";
  bool showPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(20)),
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                      child: Text(
                    "News App",
                    style: TextStyle(
                        fontFamily: 'avenir',
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                  )),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              hintText: 'email',
                              fillColor: Colors.black12,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white24, width: 2.0),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white24, width: 2.0),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            validator: (val) => (val!.isEmpty)
                                ? 'email cannot be empty'
                                : (error.isEmpty)
                                    ? null
                                    : error,
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextFormField(
                            obscureText: showPassword,
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                child: Icon(
                                  Icons.remove_red_eye,
                                ),
                                onTap: () {
                                  setState(
                                      () => showPassword = (!showPassword));
                                },
                              ),
                              prefixIcon: Icon(Icons.lock),
                              hintText: 'password',
                              fillColor: Colors.black12,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white24, width: 2.0),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white24, width: 2.0),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            validator: (val) => (val!.isEmpty)
                                ? 'email cannot be empty'
                                : (error.isEmpty)
                                    ? null
                                    : error,
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20), // <-- Radius
                          ),
                          color: Colors.grey,
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              dynamic result = await _auth
                                  .signInWithEmailAndPassword(email, password);
                              if (result == null) {
                                setState(() =>
                                    error = 'Email Id already exist');
                              }
                            }
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        MaterialButton(
                          onPressed: () {
                            Get.toNamed("/login");
                          },
                          child: Text("Login"),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
