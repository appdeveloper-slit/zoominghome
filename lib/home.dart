import 'package:dio/dio.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoominghome/sidedrawer.dart';
import 'package:zoominghome/values/strings.dart';
import 'bottom_navigation/bottom_navigation.dart';
import 'leaddetails.dart';
import 'manage/static_method.dart';
import 'mywallet.dart';
import 'notifications.dart';
import 'otp.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late BuildContext ctx;
  TextEditingController mobileCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  String? cityCat, Token;
  int? cityId;
  bool? loading;
  List<dynamic> cityList = [];
  List<dynamic> leadList = [];
  dynamic userdata;

  getSession() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      Token = sp.getString('token') ?? '';
      userdata = sp.getString('dataregister') ?? sp.getString('datalogin');
    });
    STM().checkInternet(context, widget).then((value) {
      if (value) {
        getCity();
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
    return DoubleBack(
      message: 'Please press back once again',
      child: Scaffold(
        extendBodyBehindAppBar: true,
        bottomNavigationBar: bottomBarLayout(ctx, 0),
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
          leading: Padding(
            padding: EdgeInsets.all(18),
            child: InkWell(
                onTap: () {
                  scaffoldState.currentState?.openDrawer();
                },
                child: SvgPicture.asset('assets/drawer.svg')),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(
                top: Dim().d12,
                bottom: Dim().d12,
              ),
              child: InkWell(
                onTap: () {
                  STM().redirect2page(
                    ctx,
                    MyWallet(),
                  );
                  // STM().redirect2page(ctx, NotificationPage(), );
                },
                child: SvgPicture.asset('assets/walletcoin.svg'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: Dim().d16,
                  bottom: Dim().d16,
                  right: Dim().d20,
                  left: Dim().d24),
              child: InkWell(
                onTap: () {
                  STM().redirect2page(
                    ctx,
                    NotificationPage(),
                  );
                },
                child: SvgPicture.asset('assets/bellicon.svg'),
              ),
            )
          ],
        ),
        key: scaffoldState,
        drawer: navBar(ctx, scaffoldState),
        // resizeToAvoidBottomInset: false,
        backgroundColor: Clr().white,
        body: DecoratedBox(
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
                  height: Dim().d80,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Hi, ${userdata}',
                    style: Sty().largeText.copyWith(
                        color: Clr().primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 24),
                  ),
                ),
                SizedBox(
                  height: Dim().d100,
                ),
                Container(
                  height: Dim().d52,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                      style: TextStyle(color: Color(0xff787882)),
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
                        // STM().redirect2page(ctx, Home());
                        setState(() {
                          cityCat = t.toString();
                          int position = cityList.indexWhere((e) => e['name'].toString() == cityCat.toString());
                          cityId = cityList[position]['id'];
                          loading = true;
                        });
                        GetHomeApi(cityId);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: Dim().d16,
                ),
                loading == true
                    ? Expanded(
                      child: SizedBox(
                          height: MediaQuery.of(ctx).size.height / 1.3,
                          child: Center(
                              child: Text(
                            'Loading Leads...',
                            style: Sty().mediumBoldText,
                          ))),
                    )
                    : leadList.isEmpty
                        ? Expanded(
                          child: SizedBox(
                              height: MediaQuery.of(ctx).size.height / 1.3,
                              child: Center(
                                  child: Text(
                                    cityCat == null ? 'Select City' : 'No Leads',
                                style: Sty().mediumBoldText,
                              ))),
                        )
                        : Expanded(
                            child: MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              child: RawScrollbar(
                                thumbColor: Clr().secondaryColor,
                                radius: Radius.circular(16),
                                thickness: 5,
                                child: ListView.builder(
                                  padding: EdgeInsets.only(
                                      top: Dim().d8,
                                      right: Dim().d8,
                                      left: Dim().d8,
                                      bottom: Dim().d8),
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: leadList.length,
                                  itemBuilder: (context, index) {
                                    return cardLayout(context, index, leadList);
                                  },
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

  // home api
  void GetHomeApi(id) async {
    FormData body = FormData.fromMap({
      'city_id': id,
    });
    var result = await STM().postWithoutDialog(ctx, 'homePage', body,Token);
    var success = result['success'];
    if (result != null) {
      setState(() {
        leadList = result['data'];
        loading = false;
      });
    }else{
      setState(() {
        loading = false;
      });
      STM().errorDialog(ctx, 'Something went wrong');
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

  // card Layout

  Widget cardLayout(ctx, index, list) {
    return InkWell(
        onTap: () {
          STM().redirect2page(context, LeadDetails(leaddeatils: list[index]));
        },
        child: Container(
          margin: EdgeInsets.only(bottom: Dim().d14),
          decoration: BoxDecoration(
            color: const Color(0xffFFFFFF),
            borderRadius: BorderRadius.all(Radius.circular(Dim().d12)),
            boxShadow: [
              BoxShadow(
                color: Clr().borderColor.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 20,
                offset: const Offset(2, 8),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(Dim().d16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Date:-",
                        style: Sty().smallText.copyWith(
                              fontSize: 14,
                              color: Clr().primaryColor,
                              fontWeight: FontWeight.w400,
                            ),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' ${DateFormat('dd MMM yyyy').format(DateTime.parse(list[index]['date'].toString()))}',
                            style: Sty().smallText.copyWith(
                                color: Clr().textColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dim().d28,
                      width: Dim().d110,
                      child: ElevatedButton(
                          onPressed: () {
                            // STM().redirect2page(ctx, OTPVerification());
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 0.5,
                              backgroundColor: Clr().secondaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35))),
                          child: RichText(
                            text: TextSpan(
                              text: "Available:-",
                              style: Sty().smallText.copyWith(
                                    fontSize: 12,
                                    color: Clr().primaryColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' ${list[index]['available'].toString()}',
                                  style: Sty().smallText.copyWith(
                                      color: Clr().textColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          )),
                    )
                  ],
                ),
                SizedBox(
                  height: Dim().d8,
                ),
                RichText(
                  text: TextSpan(
                    text: "Name:-",
                    style: Sty().smallText.copyWith(
                          fontSize: 14,
                          color: Clr().primaryColor,
                          fontWeight: FontWeight.w400,
                        ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' ${list[index]['name'].toString()}',
                        style: Sty().smallText.copyWith(
                            color: Clr().textColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Dim().d16,
                ),
                RichText(
                  text: TextSpan(
                    text: "Location:-",
                    style: Sty().smallText.copyWith(
                          fontSize: 14,
                          color: Clr().primaryColor,
                          fontWeight: FontWeight.w400,
                        ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' ${list[index]['city']['name']}',
                        style: Sty().mediumText.copyWith(
                            color: Clr().textColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Dim().d24),
                Row(
                  children: [
                    SizedBox(
                      height: Dim().d44,
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                            side: BorderSide(width: 0.6, color: Colors.grey)),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: Dim().d12),
                            child: RichText(
                              text: TextSpan(
                                text: "Lead Cost:-",
                                style: Sty().smallText.copyWith(
                                      fontSize: 14,
                                      color: Clr().primaryColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' ₹ ${list[index]['lead_cost'].toString()}',
                                    style: Sty().smallText.copyWith(
                                        color: Clr().textColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}