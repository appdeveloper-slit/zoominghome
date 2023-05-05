import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoominghome/manage/static_method.dart';
import 'package:zoominghome/sidedrawer.dart';
import 'package:zoominghome/signin.dart';
import 'package:zoominghome/values/strings.dart';
import 'bottom_navigation/bottom_navigation.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  late BuildContext ctx;
  TextEditingController mobileCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController catCtrl = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  String? Token;
  bool again = false;
  int? id;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? businessCat;
  int? businessId;
  List<dynamic> BusinessCatList = [];

  getSession() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      Token = sp.getString('token') ?? '';
      // userdata = sp.getString('dataregister') ?? sp.getString('datalogin');
    });
    STM().checkInternet(context, widget).then((value) {
      if (value) {
        getBusiness();
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getSession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return WillPopScope(onWillPop: ()async{
      STM().back2Previous(ctx);
      return false;
    },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        bottomNavigationBar: bottomBarLayout(ctx, 2),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: Padding(
            padding: EdgeInsets.all(Dim().d16),
            child: InkWell(
                onTap: () {
                  STM().back2Previous(ctx);
                },
                child: SvgPicture.asset('assets/backbtn.svg')),
          ),
        ),
        backgroundColor: Clr().white,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(ctx).size.height/1.1,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/pattern.png'),
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter)),
              child: Padding(
                padding: EdgeInsets.all(Dim().d16),
                child: Column(
                  children: [
                    SizedBox(
                      height: Dim().d60,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'My Profile',
                        style: Sty().largeText.copyWith(
                            color: Clr().primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 24),
                      ),
                    ),
                    SizedBox(
                      height: Dim().d100,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: Dim().d8,
                            right: Dim().d8,
                            top: Dim().d16,
                            bottom: Dim().d8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Row(children: [
                                Text('Category:-',
                                    style: Sty().smallText.copyWith(
                                      fontSize: Dim().d16,
                                      color: Clr().primaryColor,
                                      fontWeight: FontWeight.w100,
                                    )),
                                SizedBox(width: Dim().d14),
                                SizedBox(
                                    width: Dim().d220,
                                    height: Dim().d44,
                                    child: DropdownButtonFormField(
                                      value: businessCat,
                                      hint: Text('Select Business Category',
                                        style: Sty().smallText.copyWith(
                                          color: Clr().textColor,
                                        ),
                                      ),
                                      isExpanded: true,
                                      decoration: Sty().TextFormFieldOutlineDarkStyleWithProfile.copyWith(
                                        fillColor: Clr().white,
                                        filled: true,
                                      ),
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                        size: 20,
                                        color: Clr().primaryColor,
                                      ),
                                      style: TextStyle(color: Color(0xff787882)),
                                      items: BusinessCatList.map((string) {
                                        return DropdownMenuItem(
                                          value: string['name'],
                                          child: Text(
                                            string['name'],
                                            style: Sty().mediumText.copyWith(
                                              color: Clr().textColor,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (t) {
                                        setState(() {
                                          businessCat = t.toString();
                                          int position = BusinessCatList.indexWhere((e) => e['name'].toString() == businessCat.toString());
                                          businessId = BusinessCatList[position]['id'];
                                        });
                                      },
                                    )
                                  // TextField(
                                  //   controller: catCtrl,
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: Sty()
                                  //       .TextFormFieldOutlineDarkStyleWithProfile
                                  //       .copyWith(
                                  //         fillColor: Clr().white,
                                  //         filled: true,
                                  //       ),
                                  // ),
                                ),
                              ]),
                            ),
                            SizedBox(
                              height: Dim().d16,
                            ),
                            FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Row(children: [
                                Text('Name:-',
                                    style: Sty().smallText.copyWith(
                                      fontSize: Dim().d16,
                                      color: Clr().primaryColor,
                                      fontWeight: FontWeight.w100,
                                    )),
                                SizedBox(
                                  width: Dim().d36,
                                ),
                                SizedBox(
                                  width: Dim().d220,
                                  height: Dim().d44,
                                  child: TextField(
                                    controller: nameCtrl,
                                    keyboardType: TextInputType.text,
                                    autofocus: false,
                                    decoration: Sty()
                                        .TextFormFieldOutlineDarkStyleWithProfile
                                        .copyWith(
                                      fillColor: Clr().white,
                                      filled: true,
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                            SizedBox(
                              height: Dim().d16,
                            ),
                            FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Row(
                                children: [
                                  Row(children: [
                                    Text('Mobile No. :-',
                                        style: Sty().smallText.copyWith(
                                          fontSize: Dim().d16,
                                          color: Clr().primaryColor,
                                          fontWeight: FontWeight.w100,
                                        )),
                                    SizedBox(
                                      width: Dim().d220,
                                      height: Dim().d44,
                                      child: TextField(
                                        controller: mobileCtrl,
                                        readOnly: true,
                                        autofocus: false,
                                        keyboardType: TextInputType.text,
                                        decoration:
                                        Sty().TextFormFieldWithoutStyle.copyWith(
                                          fillColor: Clr().white,
                                          filled: true,
                                        ),
                                      ),
                                    ),
                                  ]),
                                  InkWell(
                                      onTap: () {
                                        updateMobileNumber();
                                      },
                                      child: SvgPicture.asset('assets/editbtn.svg')),
                                ],
                              ),
                            ),
                            SizedBox(height: Dim().d16),
                            FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Row(children: [
                                Text('Email Address:- ',
                                    style: Sty().smallText.copyWith(
                                      fontSize: Dim().d16,
                                      color: Clr().primaryColor,
                                      fontWeight: FontWeight.w100,
                                    )),
                                SizedBox(
                                  width: Dim().d200,
                                  height: Dim().d44,
                                  child: TextField(
                                    controller: emailCtrl,
                                    keyboardType: TextInputType.emailAddress,
                                    autofocus: false,
                                    decoration: Sty()
                                        .TextFormFieldOutlineDarkStyleWithProfile
                                        .copyWith(
                                      fillColor: Clr().white,
                                      filled: true,
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                            SizedBox(height: Dim().d36),
                            Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: Dim().d40,
                                width: Dim().d180,
                                child: ElevatedButton(
                                    onPressed: () {
                                      updateProfile();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0.5,
                                        backgroundColor: Clr().primaryColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(35))),
                                    child: Text(
                                      'Update',
                                      style: Sty().mediumText.copyWith(
                                          fontSize: 16,
                                          color: Clr().secondaryColor,
                                          fontWeight: FontWeight.w400),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            SharedPreferences sp = await SharedPreferences.getInstance();
                            sp.clear();
                            STM().finishAffinity(context, SingIn());
                          },
                          child: SizedBox(
                            height: Dim().d48,
                            width: Dim().d220,
                            child: Card(
                              elevation: 0.5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35),
                                  side: BorderSide(
                                      width: 1, color: Clr().primaryColor)),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset('assets/logout.svg'),
                                    SizedBox(
                                      width: Dim().d8,
                                    ),
                                    Text(
                                      'Log Out',
                                      style: Sty().largeText.copyWith(
                                          color: Clr().primaryColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dim().d8,
                        ),
                        InkWell(
                          onTap: () {
                            deleteProfile();
                          },
                          child: Column(
                            children: [
                              Text(
                                'Delete My Account',
                                style: Sty().smallText.copyWith(
                                    height: 1.5,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Clr().primaryColor),
                              ),
                              SizedBox(
                                height: Dim().d4,
                              ),
                              Text(
                                '____________',
                                style: Sty().smallText.copyWith(
                                    height: -0.1,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Clr().primaryColor),
                              ),
                              SizedBox(
                                height: Dim().d28,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ),
    );
  }

  // get profile
  void getProfile() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var result =
        await STM().getWithoutDialogtoken(ctx, 'profileDetails', Token);
    var success = result['success'];
    if (success) {
      setState(() {
        nameCtrl = TextEditingController(text: result['data']['name']);
        mobileCtrl = TextEditingController(text: result['data']['mobile']);
        emailCtrl = TextEditingController(text: result['data']['email']);
        id = result['data']['id'];
        sp.setString('dataregister', result['data']['name']);
        sp.setString('datalogin', result['data']['name']);
        businessCat = result['data']['category']['name'];
      });
    }
  }

// updateprofile
  void updateProfile() async {
    FormData body = FormData.fromMap({
      'id': id,
      'name': nameCtrl.text,
      'email': emailCtrl.text,
      'category': businessId,
    });
    var result = await STM()
        .posttoken(ctx, Str().updating, 'updateProfile', body, Token);
    var success = result['success'];
    var message = result['message'];
    if (success) {
      STM().displayToast(message);
      getBusiness();
    } else {
      STM().errorDialog(ctx, message);
    }
  }

  void resendOtp(mobilenumber) async {
    FormData body = FormData.fromMap({
      'mobile': mobilenumber,
    });
    var result = await STM().post(ctx, Str().sendingOtp, 'resendOtp', body);
    var success = result['success'];
    var message = result['message'];
    if(success){
      STM().displayToast(message);
    }else{
      STM().errorDialog(ctx, message);
    }
  }

//Update mobile pop up
  void updateMobileNumber() {
    bool otpsend = false;
    // var updateUserMobileNumberController;
    // updateUserMobileNumberController.text = "";
    // updateUserOtpController.text = "";
    showDialog(
        barrierDismissible: false,
        context: ctx,
        builder: (context) {
          TextEditingController updateUserMobileNumberController =
              TextEditingController();
          TextEditingController updateUserOtpController =
              TextEditingController();
          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              title: Text("Change Mobile Number",
                  style:
                      Sty().mediumBoldText.copyWith(color: Color(0xff2C2C2C))),
              content: SizedBox(
                height: 120,
                width: MediaQuery.of(ctx).size.width,
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                            visible: !otpsend,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "New Mobile Number",
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Form(
                                  key: _formKey,
                                  child: TextFormField(
                                    controller:
                                        updateUserMobileNumberController,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Mobile filed is required';
                                      }
                                      if (value.length != 10) {
                                        return 'Mobile digits must be 10';
                                      }
                                    },
                                    maxLength: 10,
                                    decoration: Sty()
                                        .TextFormFieldOutlineStyle
                                        .copyWith(
                                          counterText: "",
                                          hintText: "Enter Mobile Number",
                                          prefixIconConstraints: BoxConstraints(
                                              minWidth: 50, minHeight: 0),
                                          suffixIconConstraints: BoxConstraints(
                                              minWidth: 10, minHeight: 2),
                                          border: InputBorder.none,
                                          // prefixIcon: Icon(
                                          //   Icons.phone,
                                          //   size: iconSizeNormal(),
                                          //   color: primary(),
                                          // ),
                                        ),
                                  ),
                                ),
                              ],
                            )),
                        Visibility(
                            visible: otpsend,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "One Time Password",
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: TextFormField(
                                    controller: updateUserOtpController,
                                    keyboardType: TextInputType.number,
                                    maxLength: 4,
                                    decoration: InputDecoration(
                                      counterText: "",
                                      hintText: "Enter OTP",
                                      prefixIconConstraints:
                                          const BoxConstraints(
                                              minWidth: 50, minHeight: 0),
                                      suffixIconConstraints:
                                          const BoxConstraints(
                                              minWidth: 10, minHeight: 2),
                                      border: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Color(0xff2C2C2C),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: Dim().d8,
                                    ),
                                    Column(
                                      children: [
                                        Visibility(
                                          visible: !again,
                                          child: TweenAnimationBuilder<
                                                  Duration>(
                                              duration:
                                                  const Duration(seconds: 60),
                                              tween: Tween(
                                                  begin: const Duration(
                                                      seconds: 60),
                                                  end: Duration.zero),
                                              onEnd: () {
                                                // ignore: avoid_print
                                                // print('Timer ended');
                                                setState(() {
                                                  again = true;
                                                });
                                              },
                                              builder: (BuildContext context,
                                                  Duration value,
                                                  Widget? child) {
                                                final minutes = value.inMinutes;
                                                final seconds =
                                                    value.inSeconds % 60;
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 5),
                                                  child: Text(
                                                    "Re-send code in $minutes:$seconds",
                                                    textAlign: TextAlign.center,
                                                    style: Sty().mediumText,
                                                  ),
                                                );
                                              }),
                                        ),
                                        // Visibility(
                                        //   visible: !isResend,
                                        //   child: Text("I didn't receive a code! ${(  sTime  )}",
                                        //       style: Sty().mediumText),
                                        // ),
                                        SizedBox(
                                          height: Dim().d8,
                                        ),
                                        Visibility(
                                          visible: again,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                again = false;
                                              });
                                              resendOtp(updateUserMobileNumberController.text);
                                              // resendOtp(
                                              //     updateUserMobileNumberController
                                              //         .text);
                                              // STM.checkInternet().then((value) {
                                              //   if (value) {
                                              //     sendOTP();
                                              //   } else {
                                              //     STM.internetAlert(ctx, widget);
                                              //   }
                                              // });
                                            },
                                            child: Text(
                                              'Resend OTP',
                                              style: Sty().mediumText,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ]),
                ),
              ),
              elevation: 0,
              actions: [
                Row(
                  children: [
                    Visibility(
                      visible: !otpsend,
                      child: Expanded(
                        child: InkWell(
                          onTap: () async {
                            // API UPDATE START
                            if (_formKey.currentState!.validate()) {
                              SharedPreferences sp =
                                  await SharedPreferences.getInstance();
                              FormData body = FormData.fromMap({
                                'page_type': 'update_mobile',
                                'mobile': updateUserMobileNumberController.text,
                              });
                              var result = await STM()
                                  .post(ctx, Str().sendingOtp, 'sendOtp', body);
                              var success = result['success'];
                              var message = result['message'];
                              if (success) {
                                setState(() {
                                  otpsend = true;
                                });
                              } else {
                                STM().errorDialog(context, message);
                              }
                            }
                            // API UPDATE END
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Clr().primaryColor,
                            ),
                            child: const Center(
                              child: Text(
                                "Send OTP",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: otpsend,
                      child: Expanded(
                        child: InkWell(
                            onTap: () async {
                              // API UPDATE START
                              SharedPreferences sp =
                                  await SharedPreferences.getInstance();
                              FormData body = FormData.fromMap({
                                'page_type': 'update_mobile',
                                'user_id': id,
                                'otp': updateUserOtpController.text,
                                'mobile': updateUserMobileNumberController.text,
                              });
                              var result = await STM().posttoken(ctx, Str().updating, 'verifyOtp', body, Token);
                              var success = result['success'];
                              var message = result['message'];
                              if (success) {
                                STM().displayToast(message);
                                STM().back2Previous(ctx);
                                getProfile();
                              } else {
                                STM().errorDialog(context, message);
                              }
                              setState(() {
                                otpsend = true;
                              });
                            },
                            child: Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Clr().primaryColor,
                                ),
                                child: const Center(
                                    child: Text(
                                  "Update",
                                  style: TextStyle(color: Colors.white),
                                )))),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Clr().primaryColor,
                              ),
                              child: const Center(
                                  child: Text("Cancel",
                                      style: TextStyle(color: Colors.white))))),
                    ),
                  ],
                ),
              ],
              actionsAlignment: MainAxisAlignment.center,
            ),
          );
        });
  }

// delete account
  void deleteProfile() async {
    FormData body = FormData.fromMap({
      'id': id,
    });
    var result = await STM()
        .posttoken(ctx, Str().deleting, 'deleteAccount', body, Token);
    var success = result['success'];
    var message = result['message'];
    if (success) {
      STM().successDialogWithAffinity(ctx, message, SingIn());
    } else {
      STM().errorDialog(ctx, message);
    }
  }

  // getbuisness
  void getBusiness() async {
    var result = await STM().getWithoutDialog(ctx, 'business_category');
    var status = result['success'];
    if (status) {
      setState(() {
        BusinessCatList = result['category'];
      });
      getProfile();
    }
  }
}
