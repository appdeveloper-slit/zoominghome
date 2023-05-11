import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoominghome/home.dart';
import 'package:zoominghome/sidedrawer.dart';
import 'package:zoominghome/values/strings.dart';
import 'manage/static_method.dart';
import 'otp.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

class MyWallet extends StatefulWidget {
  const MyWallet({super.key});

  @override
  State<MyWallet> createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  late BuildContext ctx;
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  List<dynamic> datalist = [];

  final List<String> _wordName = [
    "Yes",
    "No",
  ];
  String walletamount = '0';
  int _selectedIndex2 = 0;
  int? total,preWalletId;
  double? totalamount;
  var UserId;
  var _razorpay = Razorpay();
  final List<String> _wordName2 = [
    "1000",
    "2000",
    "3000",
    "4000",
    "5000",
    "10000",
  ];
  String? Token;

  getSession() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      Token = sp.getString('token') ?? '';
      UserId = sp.getString('userid') ?? '';
      // userdata = sp.getString('dataregister') ?? sp.getString('datalogin');
    });
    STM().checkInternet(context, widget).then((value) {
      if (value) {
        getWallet();
        print(Token);
        print(UserId);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getSession();
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    addWallet(trans_id: response.paymentId, pre: 'No',preid: preWalletId);
    debugPrint(response.paymentId);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message.toString(),
        timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName.toString(), timeInSecForIosWeb: 4);
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return WillPopScope(
      onWillPop: () async {
        STM().finishAffinity(ctx, HomePage());
        return false;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        key: scaffoldState,
        drawer: navBar(ctx, scaffoldState),
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
            padding: EdgeInsets.all(Dim().d16),
            child: InkWell(
                onTap: () {
                  STM().finishAffinity(ctx, HomePage());
                },
                child: SvgPicture.asset('assets/backbtn.svg')),
          ),
        ),
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
                  height: Dim().d60,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'My Wallet',
                    style: Sty().largeText.copyWith(
                        color: Clr().primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 24),
                  ),
                ),
                SizedBox(
                  height: Dim().d24,
                ),
                SizedBox(
                  height: Dim().d90,
                ),
                Row(
                  children: [
                    Text(
                      'Coins:- ',
                      style: Sty().largeText.copyWith(
                          color: Clr().primaryColor,
                          fontWeight: FontWeight.w300,
                          fontSize: 18),
                    ),
                    SvgPicture.asset('assets/coins.svg'),
                    SizedBox(width: Dim().d4),
                    Text(
                      '${walletamount}',
                      style: Sty().largeText.copyWith(
                          color: Clr().primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                    SizedBox(
                      width: Dim().d28,
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            plansDialog(ctx);
                          },
                          child: Text(
                            '+ Add Money',
                            style: Sty().smallText.copyWith(
                                height: 1.5,
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: Clr().primaryColor),
                          ),
                        ),
                        SizedBox(
                          height: Dim().d2,
                        ),
                        Text(
                          '________',
                          style: Sty().smallText.copyWith(
                              height: -0.1,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Clr().primaryColor),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: Dim().d28,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PopupMenuButton(
                      offset: Offset(-15, 15),
                      position: PopupMenuPosition.under,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Sort by ',
                            style: Sty().largeText.copyWith(
                                color: Clr().primaryColor,
                                fontWeight: FontWeight.w300,
                                fontSize: 15),
                          ),
                          SizedBox(width: Dim().d8),
                          SvgPicture.asset('assets/sortby.svg',
                              height: Dim().d20),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dim().d12),
                          bottomLeft: Radius.circular(Dim().d12),
                          bottomRight: Radius.circular(Dim().d12),
                        ),
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 0,
                          // row with 2 children
                          child: SizedBox(
                            width: Dim().d120,
                            child: const Text("Debit"),
                          ),
                        ),
                        // PopupMenuItem 2
                        PopupMenuItem(
                          value: 1,
                          // row with two children`
                          child: SizedBox(
                            width: Dim().d120,
                            child: const Text("Credit"),
                          ),
                        ),
                        PopupMenuItem(
                          value: 2,
                          // row with two children
                          child: SizedBox(
                            width: Dim().d120,
                            child: const Text("Refund"),
                          ),
                        ),
                      ],
                      onSelected: (value) {
                        datalist.clear();
                        getWallet(sortby: value);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: Dim().d8,
                ),
                datalist.isEmpty
                    ? Expanded(
                        child: SizedBox(
                          height: MediaQuery.of(ctx).size.height / 1.3,
                          child: Center(
                            child: Text('No Transaction',
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
                              physics: BouncingScrollPhysics(),
                              itemCount: datalist.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Clr().borderColor.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 20,
                                        offset: const Offset(2, 8),
                                      ),
                                    ],
                                  ),
                                  child: Card(
                                    elevation: 0.2,
                                    margin: EdgeInsets.only(bottom: 14),
                                    shape: RoundedRectangleBorder(
                                        // side: BorderSide(color:Clr().borderColor2 ,width: 0.5),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    color: const Color(0xffFFFFFF),
                                    child: Padding(
                                      padding: EdgeInsets.all(Dim().d16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            // crossAxisAlignment: CrossAxisAlignment.spaceBetween,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Transaction ID ',
                                                style: Sty().smallText.copyWith(
                                                    color: Clr().textColor,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15),
                                              ),
                                              SizedBox(height: Dim().d8),
                                              Text(
                                                'Date ',
                                                style: Sty().smallText.copyWith(
                                                    color: Clr().textColor,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15),
                                              ),
                                              SizedBox(height: Dim().d8),
                                              Text(
                                                  datalist[index]['txn_type'] ==
                                                          'Debit'
                                                      ? 'Debit'
                                                      : datalist[index]
                                                          ['txn_type'],
                                                  style: Sty().smallText.copyWith(
                                                      color: datalist[index][
                                                                  'txn_type'] ==
                                                              'Debit'
                                                          ? Clr().red
                                                          : Clr().green,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15)),
                                            ],
                                          ),
                                          Column(
                                            // crossAxisAlignment: CrossAxisAlignment.spaceBetween,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                ':',
                                                style: Sty().smallText.copyWith(
                                                    color: Clr().textColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15),
                                              ),
                                              SizedBox(height: Dim().d8),
                                              Text(
                                                ':',
                                                style: Sty().smallText.copyWith(
                                                    color: Clr().textColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15),
                                              ),
                                              SizedBox(height: Dim().d8),
                                              Text(
                                                ':',
                                                style: Sty().smallText.copyWith(
                                                    color: Clr().textColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            // crossAxisAlignment: CrossAxisAlignment.spaceBetween,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${datalist[index]['txn_id']}',
                                                style: Sty().smallText.copyWith(
                                                    color: Clr().textColor,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15),
                                              ),
                                              SizedBox(height: Dim().d8),
                                              Text(
                                                '${DateFormat('dd-MM-yyyy').format(DateTime.parse(datalist[index]['txn_date'].toString()))}',
                                                style: Sty().smallText.copyWith(
                                                    color: Clr().textColor,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15),
                                              ),
                                              SizedBox(height: Dim().d8),
                                              Text(
                                                datalist[index]['txn_type'] ==
                                                        'Debit'
                                                    ? '-₹ ${datalist[index]['amount']}'
                                                    : '₹ ${datalist[index]['amount']}',
                                                style: Sty().smallText.copyWith(
                                                    color: datalist[index]
                                                                ['txn_type'] ==
                                                            'Debit'
                                                        ? Clr().red
                                                        : Clr().green,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),

                // SizedBox(
                //   height: Dim().d28,
                // ),

                // SizedBox(
                //   height: 52,
                //   width: 230,
                //   child: ElevatedButton(
                //       onPressed: () {
                //         STM().redirect2page(ctx, OTPVerification());
                //       },
                //       style: ElevatedButton.styleFrom(
                //           elevation: 0.5,
                //           backgroundColor: Clr().primaryColor,
                //           shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(35))),
                //       child: Text(
                //         'Send OTP',
                //         style: Sty().mediumText.copyWith(
                //           fontSize: 16,
                //             color: Clr().secondaryColor, fontWeight: FontWeight.w400),
                //       )),
                // ),

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
                // SizedBox(
                //   height: Dim().d16,
                // ),
                //
                //
                // SizedBox(
                //   height: Dim().d56,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // bool isChecked = true;
  // String? sGender;
  // List<dynamic> GenderList = [
  //   "Men",
  //   "Women",
  //   "Transgender",
  // ];

  // wallet list
  void getWallet({sortby}) async {
    FormData body = FormData.fromMap({
      'sort_by': sortby,
    });
    var result = await STM().postWithoutDialog(ctx, 'walletList', body, Token);
    setState(() {
      datalist = result['data'];
      walletamount = result['wallet_balance'];
    });
  }

  // add money to wallet
  void addWallet({trans_id, pre,preid}) async {
    FormData body = FormData.fromMap({
      'add_amount': _wordName2[_selectedIndex2],
      'txn_id': trans_id,
      'pre_wallet_id': preid,
      'user_id': UserId,
    });
    var result = await STM().posttoken(ctx, Str().processing,
        pre == 'yes' ? 'add_pre_wallet' : 'addToWallet', body, Token);
    var success = result['status'];
    var message = result['message'];
    if (success) {
      if (pre == 'yes') {
        STM().back2Previous(ctx);
        print(int.parse(_wordName2[_selectedIndex2]) * 100);
        var options = {
                'key': 'rzp_live_116uhp3pg8FCRC',
                'amount': '${int.parse(_wordName2[_selectedIndex2]) * 100}',
                //in the smallest currency sub-unit.
                'name': 'ZoomingHome',
                // 'order_id': 'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
                'order': {
                  "id": DateTime.now().millisecondsSinceEpoch.toString(),
                  "entity": "order",
                  "amount": '${int.parse(_wordName2[_selectedIndex2]) * 100}',
                  "amount_paid": 0,
                  "amount_due": '${int.parse(_wordName2[_selectedIndex2]) * 100}',
                  "currency": "INR",
                  "receipt": "Receipt #20",
                  "status": "created",
                  "attempts": 0,
                  "notes": {"key1": "value1", "key2": "value2"},
                  "created_at": DateTime.now().toString()
                },
                'description': 'Demo',
                'theme.color': '#FFD401',
                'timeout': 900,
              };
       _razorpay.open(options);
      } else {
        STM().displayToast(message);
        getWallet();
      }
     setState(() {
       preWalletId = result['id'];
     });
    } else {
      STM().errorDialog(ctx, message);
    }
  }

  plansDialog(ctx) {
    AwesomeDialog(
      context: ctx,
      dialogType: DialogType.NO_HEADER,
      animType: AnimType.BOTTOMSLIDE,
      alignment: Alignment.centerLeft,
      isDense: true,
      body: StatefulBuilder(builder: (BuildContext context, setState) {
        return Container(
          padding: EdgeInsets.all(Dim().d4),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dim().d16),
            child: Column(
              children: [
                SizedBox(
                  height: Dim().d8,
                ),
                Text(
                  'Add Money',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: Sty().smallText.copyWith(
                      height: 1.2,
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: Clr().primaryColor),
                ),
                SizedBox(
                  height: Dim().d16,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Add Money to your wallet with minimum",
                    style: Sty().smallText.copyWith(
                          fontSize: 15,
                          color: Clr().primaryColor,
                          fontWeight: FontWeight.w400,
                        ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' ₹1000',
                        style: Sty().smallText.copyWith(
                            color: Clr().textColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                      TextSpan(
                        text: ' to get started.',
                        style: Sty().smallText.copyWith(
                            color: Clr().textColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 15),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Dim().d8,
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 140,
                    width: 250,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: 6,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 40,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 1,
                      ),
                      itemBuilder: (BuildContext context, int index2) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              _selectedIndex2 = index2;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              _selectedIndex2 == index2
                                  ? SvgPicture.asset('assets/slectdrop2.svg')
                                  : SvgPicture.asset('assets/selectDrop.svg'),
                              Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: Text(
                                  '₹ ${_wordName2[index2]}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Sty().smallText.copyWith(
                                      height: 1.2,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Clr().primaryColor),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: Dim().d40,
                    width: Dim().d180,
                    child: ElevatedButton(
                        onPressed: () {
                          addWallet(pre: 'yes');
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0.5,
                            backgroundColor: Clr().primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35))),
                        child: Text(
                          'Pay Now',
                          style: Sty().mediumText.copyWith(
                              fontSize: 16,
                              color: Clr().secondaryColor,
                              fontWeight: FontWeight.w400),
                        )),
                  ),
                ),
                SizedBox(
                  height: Dim().d28,
                ),
              ],
            ),
          ),
        );
      }),
    ).show();
  }
}
