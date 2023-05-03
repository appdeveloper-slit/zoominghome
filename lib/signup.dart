import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoominghome/signin.dart';
import 'package:zoominghome/values/strings.dart';
import 'manage/static_method.dart';
import 'otp.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late BuildContext ctx;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController mobileCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();
  String? cityCat, businesserror, cityerror;
  List<dynamic> cityList = [];
  String? businessCat;
  int? businessId,cityId;
  List<dynamic> BusinessCatList = [];

  getSession() async {
    STM().checkInternet(context, widget).then((value) {
      if (value) {
        getCity();
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar
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
          )),
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
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 350,
                                  width: MediaQuery.of(context).size.width * 0.43,
                                  // width:  170,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Clr().borderColor2.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 7,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                    shape: BoxShape.rectangle,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(999)),
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(999)), // Image border
                                      child: Image.asset('assets/signup.png',
                                          fit: BoxFit.cover, scale: 0.5)),
                                ),
                                SizedBox(
                                  height: Dim().d44,
                                )
                              ],
                            ),
                            SizedBox(
                              width: Dim().d16,
                            ),
                            Container(
                              height: 350,
                              width: MediaQuery.of(context).size.width * 0.43,
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(999)),
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(999)), // Image border
                                  child: Image.asset('assets/signup2.png',
                                      fit: BoxFit.cover, scale: 0.5)),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: Dim().d20,
                        ),
                        Text(
                          'Sign Up',
                          style: Sty().largeText.copyWith(
                              color: Clr().primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 28),
                        ),
                        SizedBox(
                          height: Dim().d14,
                        ),
                        Text(
                          'Hello! Register to get started',
                          style: Sty().smallText.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Clr().black),
                        ),
                        SizedBox(
                          height: Dim().d28,
                        ),
                        Container(
                          height: Dim().d52,
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          decoration: BoxDecoration(
                              // color: Clr().white,
                              boxShadow: [
                                BoxShadow(
                                  color: Clr().grey.withOpacity(0.1),
                                  spreadRadius: 0.5,
                                  blurRadius: 12,
                                  offset: Offset(
                                      0, 4), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(35),
                              border: Border.all(
                                color: Clr().primaryColor,
                              )),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: businessCat,
                              hint: Text(
                                'Select Business Category',
                                style: Sty().mediumText.copyWith(
                                      color: Clr().textColor,
                                    ),
                              ),
                              isExpanded: true,
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size: 28,
                                color: Clr().primaryColor,
                              ),
                              style: TextStyle(color: Color(0xff787882)),
                              items: BusinessCatList.map(( string) {
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
                                  businesserror = null;
                                });
                              },
                            ),
                          ),
                        ),
                        businesserror == null
                            ? const SizedBox.shrink()
                            : Padding(
                              padding: EdgeInsets.only(left: Dim().d20,top: Dim().d12),
                              child: Text(businesserror ?? '',
                                  style: Sty()
                                      .smallText
                                      .copyWith(color: Clr().errorRed,fontSize: Dim().d12,fontWeight: FontWeight.w400)),
                            ),
                        SizedBox(
                          height: Dim().d16,
                        ),
                        Container(
                          height: Dim().d52,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          decoration: BoxDecoration(
                              // color: Clr().white,
                              boxShadow: [
                                BoxShadow(
                                  color: Clr().grey.withOpacity(0.1),
                                  spreadRadius: 0.5,
                                  blurRadius: 12,
                                  offset: Offset(0, 4), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(35),
                              border: Border.all(
                                color: Clr().primaryColor,
                              )),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: cityCat,
                              hint: Text(
                                'Select City',
                                style: Sty().mediumText.copyWith(
                                      color: Clr().textColor,
                                    ),
                              ),
                              isExpanded: true,
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size: 28,
                                color: Clr().primaryColor,
                              ),
                              style: const TextStyle(color: Color(0xff787882)),
                              items: cityList.map((string) {
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
                                  int position = cityList.indexWhere((e) =>
                                      e['name'].toString() == t.toString());
                                  cityCat = t.toString();
                                  cityId = cityList[position]['id'];
                                  cityerror = null;
                                });
                              },
                            ),
                          ),
                        ),
                        cityerror == null
                            ? const SizedBox.shrink()
                            : Padding(
                              padding:  EdgeInsets.only(left: Dim().d20,top: Dim().d12),
                              child: Text(cityerror ?? '', style: Sty().smallText.copyWith(color: Clr().errorRed,fontSize: Dim().d12,fontWeight: FontWeight.w400)),
                            ),
                        SizedBox(
                          height: Dim().d16,
                        ),
                        TextFormField(
                          controller: nameCtrl,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Name is required';
                            }
                          },
                          decoration: InputDecoration(
                            fillColor: Clr().lightGrey,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                                borderSide: BorderSide(
                                  color: Clr().red,
                                )),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Clr().primaryColor, width: 1.1),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: Dim().d20,vertical: Dim().d12),
                            // label: Text('Enter Your Number'),
                            hintText: "Enter Name",
                            // labelText: 'Mobile Number',
                            // labelStyle: TextStyle(color:Clr().textColor),
                            hintStyle: Sty().mediumText.copyWith(
                                  color: Clr().textColor,
                                ),
                            counterText: "",
                          ),
                          maxLength: 50,
                        ),
                        SizedBox(
                          height: Dim().d16,
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
                                borderSide: BorderSide(
                                  color: Clr().red,
                                )),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Clr().primaryColor, width: 1.1),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: Dim().d20,vertical: Dim().d12),
                            // label: Text('Enter Your Number'),
                            hintText: "Enter Mobile Number",
                            // labelText: 'Mobile Number',
                            labelStyle: TextStyle(color: Clr().textColor),
                            hintStyle: Sty().mediumText.copyWith(
                                  color: Clr().textColor,
                                ),
                            counterText: "",
                          ),
                          maxLength: 10,
                        ),
                        SizedBox(
                          height: Dim().d16,
                        ),

                        TextFormField(
                          controller: emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }
                            if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                              return "Please enter a valid email address";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            fillColor: Clr().lightGrey,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                                borderSide: BorderSide(
                                  color: Clr().red,
                                )),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Clr().primaryColor, width: 1.1),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: Dim().d20,vertical: Dim().d12),
                            // label: Text('Enter Your Number'),
                            hintText: "Enter Email Address",
                            // labelText: 'Mobile Number',
                            labelStyle: TextStyle(color: Clr().textColor),
                            hintStyle: Sty().mediumText.copyWith(
                                  color: Clr().textColor,
                                ),
                            counterText: "",
                          ),
                          maxLength: 30,
                        ),
                        SizedBox(
                          height: Dim().d28,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: 52,
                            width: 230,
                            child: ElevatedButton(
                                onPressed: () {
                                  _validateForm(ctx);
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
                                      color: Clr().secondaryColor,
                                      fontWeight: FontWeight.w400),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: Dim().d16,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {
                              STM().finishAffinity(ctx, const SingIn());
                            },
                            child: RichText(
                              text: TextSpan(
                                text: "Already Registered ?",
                                style: Sty().smallText.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Clr().black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' Sign In Now',
                                    style: Sty().smallText.copyWith(
                                        color: Clr().primaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
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

  // validation funtion
  _validateForm(ctx) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool _isValid = formKey.currentState!.validate();

    if (businessCat == null) {
      setState(() => businesserror = "Business category is required");
      _isValid = false;
    }
    if (cityCat == null) {
      setState(() {
        cityerror = "City is required";
      });
      _isValid = false;
    }
    if (_isValid) {
      registerApi();
    }
  }

  // register
  void registerApi() async {
    FormData body = FormData.fromMap({
      'business_category': businessId,
      'city_id': cityId,
      'name': nameCtrl.text,
      'mobile': mobileCtrl.text,
      'email': emailCtrl.text,
      'page_type': 'register',
    });
    var result = await STM().post(ctx, Str().sendingOtp, 'sendOtp', body);
    var success = result['success'];
    var message = result['message'];
    if (success) {
      STM().displayToast(message);
     STM().redirect2page(ctx,  OTPVerification(list: [{
       'business_category': businessId,
       'city_id': cityId,
       'name': nameCtrl.text,
       'mobile': mobileCtrl.text,
       'email': emailCtrl.text,
       'page_type': 'register',
     }]));
    } else {
      STM().errorDialog(ctx, message);
    }
  }

// getCity
  void getCity() async {
    var result = await STM().getWithoutDialog(ctx, 'cityList');
    var status = result['status'];
    if (status) {
      setState(() {
        cityList = result['data'];
      });
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
    }
  }
}
