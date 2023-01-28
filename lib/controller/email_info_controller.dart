import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
// import '../models/user.dart';
import '../services/auth.dart';

class EmailInfoController extends GetxController{
    var isVerified = true.obs;
    var email = "".obs;
    var password = "".obs;
    var name = "".obs;
    var error = "".obs;
    var showPassword = true.obs;

    void changeEmail(var emailValue){
       email.value = emailValue;
    }
    void changePassword(var emailValue){
        password.value = emailValue;
    }
    void changeError(var emailValue){
        error.value = emailValue;
    }
    void changeShowPassword(){
        showPassword.value = !showPassword.value;
    }
    void verificationMode(bool k){
        isVerified.value = k;
    }




}