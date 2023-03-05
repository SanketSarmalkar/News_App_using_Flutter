import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controller/email_info_controller.dart';
import 'package:news_app/services/auth.dart';

class Login extends StatefulWidget {
  final Function changeK;
  const Login({Key? key, required this.changeK}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //final _formkey = GlobalKey<FormState>();

  final AuthService _auth = AuthService();

  EmailInfoController emailInfoController = Get.put(EmailInfoController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
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
                  child: Column(
                    children: const [
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Icon(Icons.newspaper,),
                      // ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
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
                    ],
                  ),
                ),
                const SizedBox(
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
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.email),
                                hintText: 'email',
                                fillColor: Colors.black12,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white24, width: 2.0),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white24, width: 2.0),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white24, width: 2.0),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                errorStyle: const TextStyle(color: Colors.grey),
                              ),
                              onChanged: (val) {
                                emailInfoController.changeEmail(val);
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              obscureText:
                                  emailInfoController.showPassword.value,
                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  child: const Icon(
                                    Icons.remove_red_eye,
                                  ),
                                  onTap: () {
                                    emailInfoController.changeShowPassword();
                                  },
                                ),
                                prefixIcon: const Icon(Icons.lock),
                                hintText: 'password',
                                fillColor: Colors.black12,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white24, width: 2.0),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white24, width: 2.0),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onChanged: (val) {
                                emailInfoController.changePassword(val);
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(20), // <-- Radius
                            ),
                            color: Colors.grey,
                            onPressed: () async {
                              // ignore: unrelated_type_equality_checks
                              if (emailInfoController.email != "" &&
                                  emailInfoController.password
                                          .toString()
                                          .length >=
                                      8) {
                                dynamic result =
                                    await _auth.signInWithEmailAndPassword(
                                        emailInfoController.email.toString(),
                                        emailInfoController.password
                                            .toString());
                                if (result == null) {
                                  emailInfoController.changeError(
                                      'Invalid EmailId or wrong password');
                                  Get.snackbar(
                                    "Error",
                                    emailInfoController.error.toString(),
                                    icon: const Icon(Icons.error,
                                        color: Colors.white),
                                    backgroundColor: Colors.black12,
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                }
                              } else {
                                emailInfoController.changeError(
                                    (emailInfoController.email.toString() == "")
                                        ? "email can't be empty"
                                        : "password should contain min. 8 characters");
                                Get.snackbar(
                                  "Error",
                                  emailInfoController.error.toString(),
                                  icon: const Icon(Icons.error,
                                      color: Colors.white),
                                  backgroundColor: Colors.black12,
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              }
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              widget.changeK();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text("Don't have an account?"),
                                Text(
                                  " Sign Up",
                                  style: TextStyle(color: Colors.blue),
                                )
                              ],
                            ),
                          ),
                          const Text("Or sign Up"),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              color: Colors.grey,
                              onPressed: () async {
                                dynamic result = await _auth.signInWithGoogle();
                                if (result == null) {
                                  emailInfoController.changeError(
                                      'Something went wrong, try again later...');
                                  Get.snackbar(
                                    "Error",
                                    emailInfoController.error.toString(),
                                    icon: const Icon(Icons.error,
                                        color: Colors.white),
                                    backgroundColor: Colors.black12,
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                } else {
                                  emailInfoController
                                      .changeError('Successfully Signed In');
                                  Get.snackbar(
                                    "Success",
                                    emailInfoController.error.toString(),
                                    icon: const Icon(Icons.check_circle,
                                        color: Colors.green),
                                    backgroundColor: Colors.white,
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'images/google.png',
                                      height: 25,
                                    ),
                                  ),
                                  const Text(" With Google"),
                                ],
                              ),
                            ),
                          ),
                          // MaterialButton(
                          //   color: Colors.grey,
                          //   onPressed: (){},
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       Padding(
                          //         padding: const EdgeInsets.all(8.0),
                          //         child: Image.asset('images/Facebook.png',height: 25,),
                          //       ),
                          //       Text("Facebook"),
                          //     ],
                          //   ),
                          // ),
                          // MaterialButton(
                          //   color: Colors.grey,
                          //   onPressed: (){},
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       Padding(
                          //         padding: const EdgeInsets.all(8.0),
                          //         child: Image.asset('images/Microsoft.png',height: 25,),
                          //       ),
                          //       Text("Microsoft"),
                          //     ],
                          //   ),
                          // )
                          // Padding(
                          //   padding: EdgeInsets.only(top: 50, bottom: 20),
                          //   child: Text("@ VidyudhanuLabs"),
                          // ),
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
