import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoominghome/signin.dart';
import 'package:zoominghome/values/strings.dart';
import 'home.dart';
import 'manage/static_method.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

class OTPVerification extends StatefulWidget {
  final dynamic list;
  final dynamic list2;
  const OTPVerification({super.key,this.list,this.list2});

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  late BuildContext ctx;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController otpCtrl = TextEditingController();
  bool again = false;
  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),

      // resizeToAvoidBottomInset: false,
      backgroundColor: Clr().white,
      body: Container(
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
                                    child: Image.asset('assets/otp1.png',fit: BoxFit.cover, scale: 0.5)),
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
                                child: Image.asset('assets/otp2.png',fit: BoxFit.cover, scale: 0.5)),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: Dim().d20,
                      ),
                      Text(
                        'OTP Verification',
                        style: Sty().largeText.copyWith(
                            color: Clr().primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 28),
                      ) ,
                      SizedBox(
                        height: Dim().d14,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'We’ve sent you the verification code\n on  ${widget.list != null ? widget.list[0]['mobile'] : widget.list2[0]['mobile']}', textAlign: TextAlign.center,
                          style: Sty().smallText.copyWith(
                            height: 1.2,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Clr().textColor),
                        ),
                      ) ,
                      SizedBox(
                        height: Dim().d28,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: Dim().d32,right: Dim().d32 ),
                        child: PinCodeTextField(
                          controller: otpCtrl,
                          // errorAnimationController: errorController,
                          appContext: context,
                          enableActiveFill: true,
                          textStyle: Sty().mediumText,
                          length: 4,
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          animationType: AnimationType.scale,
                          cursorColor: Clr().textColor,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(35),bottomRight: Radius.circular(35),bottomLeft: Radius.circular(35),topLeft:Radius.circular(35) ),
                            fieldWidth: Dim().d52,
                            fieldHeight: Dim().d68,
                            selectedFillColor: Clr().transparent,
                            activeFillColor: Clr().transparent,
                            inactiveFillColor: Clr().transparent,
                            inactiveColor: Clr().grey,
                            activeColor: Clr().textColor,
                            borderWidth: 1,
                            selectedColor: Clr().textColor,
                          ),
                          animationDuration: const Duration(milliseconds: 200),
                          onChanged: (value) {},
                          validator: (value) {
                            if (value!.isEmpty || !RegExp(r'(.{4,})').hasMatch(value)) {
                              return "";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: Dim().d24,
                      ),

                      SizedBox(
                        height: 52,
                        width: 230,
                        child: ElevatedButton(
                            onPressed: () {
                              verifyApi();
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 0.5,
                                backgroundColor: Clr().primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(35))),
                            child: Text(
                              'Verify',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Center(
                                child: Visibility(
                                  visible: !again,
                                  child: TweenAnimationBuilder<Duration>(
                                      duration: const Duration(seconds: 60),
                                      tween: Tween(
                                          begin: const Duration(seconds: 60),
                                          end: Duration.zero),
                                      onEnd: () {
                                        // ignore: avoid_print
                                        // print('Timer ended');
                                        setState(() {
                                          again = true;
                                        });
                                      },
                                      builder: (BuildContext context,
                                          Duration value, Widget? child) {
                                        final minutes = value.inMinutes;
                                        final seconds = value.inSeconds % 60;
                                        return Column(
                                          children: [
                                            // Text(
                                            //   'Haven’t recived the verification code?',
                                            //   style: Sty()
                                            //       .mediumText
                                            //       .copyWith(color: Clr().grey),
                                            // ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 5),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Re-send code in",
                                                    textAlign: TextAlign.center,
                                                    style: Sty().mediumText.copyWith(
                                                      fontSize: Dim().d16,
                                                      color: const Color(0xFF4D3557),
                                                      fontFamily: 'roboto',
                                                    ),
                                                  ), Text(
                                                    " $minutes:$seconds",
                                                    textAlign: TextAlign.center,
                                                    style: Sty().mediumText.copyWith(
                                                      fontSize: Dim().d16,
                                                      fontWeight: FontWeight.w800,
                                                      color: const Color(0xFF291C2E),
                                                      fontFamily: 'roboto',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                ),
                              ),
                              Visibility(
                                visible: again,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      again = false;
                                    });
                                    // STM.checkInternet().then((value) {
                                    //   if (value) {
                                    //     sendOTP();
                                    //   } else {
                                    //     STM.internetAlert(ctx, widget);
                                    //   }
                                    // });
                                    // resendOTP(widget.sMobile);
                                  },
                                  child: Text(
                                    'Resend Code',
                                    style: Sty()
                                        .mediumBoldText
                                        .copyWith(color: Clr().primaryColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
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
    );
  }

  // verify OTP
  void verifyApi() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    FormData body = FormData.fromMap({
      'business_category': widget.list != null ? widget.list[0]['business_category'] : '',
      'city_id': widget.list != null ? widget.list[0]['city_id']: '',
      'name': widget.list != null ? widget.list[0]['name']: '',
      'mobile': widget.list != null ? widget.list[0]['mobile'] : widget.list2[0]['mobile'],
      'email': widget.list != null ? widget.list[0]['email'] : '',
      'page_type': widget.list != null ? widget.list[0]['page_type'] :  widget.list2[0]['page_type'],
      'otp': otpCtrl.text,
    });
    var result = await STM().post(ctx, Str().verifying, 'verifyOtp', body);
    var success = result['success'];
    var message = result['message'];
    if (success) {
      widget.list != null ? STM().successDialogWithAffinity(ctx, message, SingIn()) : STM().successDialogWithAffinity(ctx, message, HomePage());
      sp.setBool('login', true);
      widget.list != null ? sp.setString('dataregister', result['data']['name']) : sp.setString('datalogin', result['user_info']['name']);
      widget.list != null ? null : sp.setString('token', result['customer_token']);
    } else {
      STM().errorDialog(ctx, message);
    }
  }




}
