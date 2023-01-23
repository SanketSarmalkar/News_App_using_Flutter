import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controller/email_info_controller.dart';
import 'package:news_app/services/auth.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  final _formkey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  EmailInfoController emailInfoController = Get.put(EmailInfoController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
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
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white24, width: 2.0),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                errorStyle: TextStyle(color: Colors.grey),
                              ),
                              onChanged: (val) {
                                emailInfoController.changeEmail(val);
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              obscureText:
                                  emailInfoController.showPassword.value,
                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  child: Icon(
                                    Icons.remove_red_eye,
                                  ),
                                  onTap: () {
                                    emailInfoController.changeShowPassword();
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
                              onChanged: (val) {
                                emailInfoController.changePassword(val);
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
                              if (emailInfoController.email != "" &&
                                  emailInfoController.password
                                          .toString()
                                          .length >=
                                      8) {
                                dynamic result =
                                    await _auth.registerWithEmailAndPassword(
                                        emailInfoController.email.toString(),
                                        emailInfoController.password
                                            .toString());
                                if (result == null) {
                                  emailInfoController
                                      .changeError('Email Id already exist');
                                  Get.snackbar(
                                    "Error",
                                    emailInfoController.error.toString(),
                                    icon:
                                        Icon(Icons.error, color: Colors.white),
                                    backgroundColor: Colors.black12,
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                }else{
                                  Get.back();
                                }
                              } else {
                                emailInfoController.changeError(
                                    (emailInfoController.email.toString() == "")
                                        ? "email can't be empty"
                                        : "password should contain min. 8 characters");
                                Get.snackbar(
                                  "Error",
                                  emailInfoController.error.toString(),
                                  icon: Icon(Icons.error, color: Colors.white),
                                  backgroundColor: Colors.black12,
                                  snackPosition: SnackPosition.BOTTOM,
                                );
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
                              Get.back();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Have an account already?"),
                                Text(
                                  " Log In",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ],
                            ),
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
      ),
    );
  }
}
