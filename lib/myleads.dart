import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoominghome/leaddetails2.dart';
import 'package:zoominghome/notifications.dart';
import 'package:zoominghome/sidedrawer.dart';
import 'package:zoominghome/values/strings.dart';
import 'bottom_navigation/bottom_navigation.dart';
import 'manage/static_method.dart';
import 'mywallet.dart';
import 'otp.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

class MyLeads extends StatefulWidget {
  const MyLeads({super.key});

  @override
  State<MyLeads> createState() => _MyLeadsState();
}

class _MyLeadsState extends State<MyLeads> {
  late BuildContext ctx;
  TextEditingController mobileCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  TextEditingController dobCtrl = TextEditingController();
  TextEditingController dobCtrl1 = TextEditingController();
  List<dynamic> leadList = [];

  Future datePicker() async {
    DateTime? picked = await showDatePicker(
      context: ctx,
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(primary: Clr().primaryColor),
          ),
          child: child!,
        );
      },
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        String s = STM().dateFormat('dd-MM-yyyy', picked);
        dobCtrl = TextEditingController(text: s);
      });
    }
  }

  Future datePicker1() async {
    DateTime? picked = await showDatePicker(
      context: ctx,
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(primary: Clr().primaryColor),
          ),
          child: child!,
        );
      },
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        String s = STM().dateFormat('dd-MM-yyyy', picked);
        dobCtrl1 = TextEditingController(text: s);
      });
    }
  }

  String? Token,walletamount;
  bool? count;
  getSession() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      Token = sp.getString('token') ?? '';
      walletamount = sp.getString('walletamount') ?? '0';
      count = sp.getBool('count') ?? false;
    });
    STM().checkInternet(context, widget).then((value) {
      if (value) {
        // getCity();
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
        bottomNavigationBar: bottomBarLayout(ctx, 1),
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
                child: Container(
                  decoration: BoxDecoration(
                      color: Clr().primaryColor,
                      borderRadius: BorderRadius.circular(Dim().d12)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dim().d16),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/mywallet.svg',width: 16,height: 18,color: Clr().golden),
                        SizedBox(width: Dim().d8),
                        SvgPicture.asset('assets/coin.svg',width: 16,height: 14),
                        Text(' ${walletamount}',
                          style: Sty().largeText.copyWith(
                              color: Clr().golden,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                // SvgPicture.asset('assets/walletcoin.svg'),
              ),
            ),
            InkWell(
              onTap: () {
                STM().redirect2page(
                  ctx,
                  NotificationPage(),
                );
              },
              child: count == true
                  ? Padding(
                padding: EdgeInsets.only(
                    top: Dim().d16,
                    bottom: Dim().d16,
                    right: Dim().d20,
                    left: Dim().d24),
                child: SvgPicture.asset('assets/notificationbell.svg'),
              )
                  : Padding(
                padding: EdgeInsets.only(
                    top: Dim().d16,
                    bottom: Dim().d16,
                    right: Dim().d20,
                    left: Dim().d24),
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
          decoration: BoxDecoration(
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
                  alignment: Alignment.center,
                  child: Text(
                    'My Leads',
                    style: Sty().largeText.copyWith(
                        color: Clr().primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 24),
                  ),
                ),
                SizedBox(
                  height: Dim().d90,
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(35),
                            ),
                            color: Clr().white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 0.5,
                                blurRadius: 7,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            readOnly: true,
                            onTap: () {
                              datePicker();
                            },
                            controller: dobCtrl,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Pickup date is required';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(top: 16, bottom: 16),
                                child: SvgPicture.asset('assets/calendar.svg'),
                              ),
                              fillColor: Clr().white,
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Clr().transparent)),
                              focusColor: Clr().primaryColor,
                              contentPadding:
                                  EdgeInsets.only(top: 18, bottom: 18),
                              hintText: "Select Date",
                              hintStyle: Sty().smallText.copyWith(
                                  color: Clr().textColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                              counterText: "",
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Dim().d8,
                      ),
                      Text(
                        'to',
                        style: Sty().mediumText,
                      ),
                      SizedBox(
                        width: Dim().d8,
                      ),
                      Expanded(
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(35),
                            ),
                            color: Clr().white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 0.5,
                                blurRadius: 7,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            readOnly: true,
                            onTap: () {
                              datePicker1();
                            },
                            controller: dobCtrl1,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Pickup date is required';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(top: 16, bottom: 16),
                                child: SvgPicture.asset('assets/calendar.svg'),
                              ),
                              fillColor: Clr().white,
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Clr().transparent)),
                              focusColor: Clr().primaryColor,
                              contentPadding:
                                  const EdgeInsets.only(top: 18, bottom: 18),
                              hintText: "Select Date",
                              hintStyle: Sty().smallText.copyWith(
                                  color: Clr().textColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                              counterText: "",
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: Dim().d44,
                  width: Dim().d146,
                  child: ElevatedButton(
                      onPressed: () {
                        getMyLeads();
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0.5,
                          backgroundColor: Clr().primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35))),
                      child: Text(
                        'Submit',
                        style: Sty().mediumText.copyWith(
                            fontSize: 16,
                            color: Clr().secondaryColor,
                            fontWeight: FontWeight.w400),
                      )),
                ),
                SizedBox(
                  height: Dim().d8,
                ),
                leadList.isEmpty
                    ? Expanded(
                        child: SizedBox(
                          height: MediaQuery.of(ctx).size.height / 1.3,
                          child: Center(
                            child: Text(
                                dobCtrl.text.isEmpty ? 'Select Date' : 'No Leads',
                                style: Sty().mediumBoldText),
                          ),
                        ),
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
                                  top: Dim().d16,
                                  right: Dim().d8,
                                  left: Dim().d8,
                                  bottom: Dim().d16),
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: leadList.length,
                              itemBuilder: (context, index) {
                                return cardLayout(ctx, index, leadList);
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

  void getMyLeads() async {
    FormData body = FormData.fromMap({
      'fromTime': dobCtrl.text,
      'toTime': dobCtrl1.text,
    });
    var result = await STM()
        .posttoken(ctx, Str().processing, 'buyedLeadList', body, Token);
    var status = result['status'];
    if (status) {
      setState(() {
        leadList = result['data'];
      });
    }
  }

  Widget cardLayout(ctx, index, list) {
    return InkWell(
      onTap: () {
        STM().redirect2page(
            ctx,
            LeadDetails2(
              myleaddetails: list[index],
            ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: Dim().d14),
        decoration: BoxDecoration(
          color: Clr().white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
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
                      text:
                          ' ${DateFormat('dd MMM yyyy').format(DateTime.parse(list[index]['buy_date'].toString()))}',
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
                  text: "Mobile No.:-",
                  style: Sty().smallText.copyWith(
                        fontSize: 14,
                        color: Clr().primaryColor,
                        fontWeight: FontWeight.w400,
                      ),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' ${list[index]['lead_mobile'].toString()}',
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
                      text: ' ${list[index]['lead_city']}',
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: Dim().d44,
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),
                          side: BorderSide(width: 0.4, color: Colors.grey)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dim().d12),
                        child: Center(
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
                                  text: ' ₹ ${list[index]['lead_cost']}',
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
                  list[index]['refund_status'] == null
                      ? Container()
                      : Row(
                          children: [
                            SvgPicture.asset('assets/pending.svg',
                                color: list[index]['refund_status'] ==
                                        'Not Approved'
                                    ? Clr().red
                                    : list[index]['refund_status'] == 'Pending'
                                        ? Clr().yellow
                                        : Clr().green),
                            SizedBox(
                              width: Dim().d4,
                            ),
                            Text(
                              '${list[index]['refund_status']}',
                              style: Sty().smallText.copyWith(
                                  color: Clr().primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                          ],
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
