import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:zoominghome/otp.dart';
import 'package:zoominghome/signup.dart';
import 'package:zoominghome/values/strings.dart';
import 'manage/static_method.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

class SingIn extends StatefulWidget {
  const SingIn({super.key});

  @override
  State<SingIn> createState() => _SingInState();
}

class _SingInState extends State<SingIn> {
  late BuildContext ctx;
  TextEditingController mobileCtrl = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //     toolbarHeight: boolTrue ? kToolbarHeight : 0.0;
      //
      //     // title: Text(''),
      //   // automaticallyImplyLeading: false,
      //   // backgroundColor: Colors.transparent,
      //   backgroundColor: Color(0x44000000),
      //   elevation: 0,
      // ),
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      // resizeToAvoidBottomInset: false,
      backgroundColor: Clr().white,
      body: Form(
        key: formKey,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Clr().borderColor2.withOpacity(0.1),
                  Clr().borderColor,
                  Colors.white,
                  Colors.white,
                ],
              )
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(Dim().d16),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Dim().d40,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 350,
                                  width:  MediaQuery.of(context).size.width* 0.43,
                                  // width:  170,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Clr().borderColor2.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 7,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.all(Radius.circular(999)),
                                  ),
                                  child: ClipRRect(
                                      borderRadius:  BorderRadius.all(Radius.circular(999)), // Image border
                                      child: Image.asset('assets/signin.png',fit: BoxFit.cover, scale: 0.5)),
                                ),
                                SizedBox(height: Dim().d44,)
                              ],
                            ),
                            SizedBox(
                              width: Dim().d16,
                            ),
                            Container(
                              height: 350,
                              width: MediaQuery.of(context).size.width* 0.43,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Clr().borderColor2.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 7,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.all(Radius.circular(999)),
                              ),
                              child: ClipRRect(
                                  borderRadius:  BorderRadius.all(Radius.circular(999)), // Image border
                                  child: Image.asset('assets/signin2.png',fit: BoxFit.cover, scale: 0.5)),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: Dim().d20,
                        ),
                        Text(
                          'Sign in',
                          style: Sty().largeText.copyWith(
                              color: Clr().primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 28),
                        ) ,
                        SizedBox(
                          height: Dim().d14,
                        ),
                        Text(
                          'Welcome back! Glad to see you again!',
                          style: Sty().smallText.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Clr().black),
                        ) ,
                        SizedBox(
                          height: Dim().d28,
                        ),
                        TextFormField(
                          controller: mobileCtrl,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Mobile number is required';
                            }
                            if (value.length != 10) {
                              return 'Mobile number digits must be 10';
                            }
                          },
                          decoration: InputDecoration(
                            fillColor: Clr().lightGrey,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                                borderSide: BorderSide(color: Clr().red,)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Clr().primaryColor, width: 1.1),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: Dim().d20,vertical: Dim().d20),
                            // label: Text('Enter Your Number'),
                            hintText: "Enter Mobile Number",
                            // labelText: 'Mobile Number',
                            labelStyle: TextStyle(color:Clr().textColor),
                            hintStyle: Sty().mediumText.copyWith(
                              color: Clr().textColor,
                            ),
                            counterText: "",
                          ),
                          maxLength: 10,
                        ),
                        SizedBox(
                          height: Dim().d28,
                        ),

                        SizedBox(
                          height: 52,
                          width: 230,
                          child: ElevatedButton(
                              onPressed: () {
                                if(formKey.currentState!.validate()) {
                                  LoginApi();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  elevation: 0.5,
                                  backgroundColor: Clr().primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(35))),
                              child: Text(
                                'Send OTP',
                                style: Sty().mediumText.copyWith(
                                  fontSize: 16,
                                    color: Clr().secondaryColor, fontWeight: FontWeight.w400),
                              )),
                        ),

                        // SizedBox(
                        //   height: 65,
                        //   width: 370,
                        //   child: ElevatedButton(
                        //       onPressed: () {
                        //         // STM().redirect2page(ctx, SignUp());
                        //       },
                        //       style: ElevatedButton.styleFrom(
                        //           elevation: 0.5,
                        //           backgroundColor: Colors.white,
                        //           side:
                        //           BorderSide(width: 1, color: Clr().primaryColor),
                        //           shape: RoundedRectangleBorder(
                        //               borderRadius: BorderRadius.circular(15))),
                        //       child: Text(
                        //         'Sign Up',
                        //         style: Sty().largeText.copyWith(
                        //             color: Clr().primaryColor,
                        //             fontWeight: FontWeight.w600),
                        //       )),
                        // ),
                        SizedBox(
                          height: Dim().d16,
                        ),

                        InkWell(
                          onTap: () {
                            STM().redirect2page(ctx, const SignUp());
                          },
                          child: RichText(
                            text: TextSpan(
                              text: "Don't have an account? ",
                              style: Sty().smallText.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Clr().black),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Register Now',
                                  style: Sty().smallText.copyWith(
                                      color: Clr().primaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dim().d56,
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  // log in
void LoginApi() async {
    FormData body = FormData.fromMap({
      'mobile': mobileCtrl.text,
      'page_type': 'login',
    });
    var result = await STM().post(ctx, Str().sendingOtp, 'sendOtp', body);
    var success = result['success'];
    var message = result['message'];
    if(success){
      STM().displayToast(message);
      OTPVerification(list2: [{
        'mobile': mobileCtrl.text,
        'page_type': 'login',
      }]);
    }else{
      STM().errorDialog(ctx, message);
    }
}

}
