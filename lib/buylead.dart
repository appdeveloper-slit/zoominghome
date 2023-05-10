import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoominghome/leaddetails2.dart';
import 'package:zoominghome/manage/static_method.dart';
import 'package:zoominghome/sidedrawer.dart';
import 'package:zoominghome/values/strings.dart';
import 'couponcode.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

class BuyLead extends StatefulWidget {
  final dynamic leaddetails;
  const BuyLead({super.key,this.leaddetails});

  @override
  State<StatefulWidget> createState() {
    return BuyLeadpage();
  }
}

class BuyLeadpage extends State<BuyLead> {
  late BuildContext ctx;
  TextEditingController mobileCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  static StreamController<dynamic> controller = StreamController<dynamic>.broadcast();
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  String? discount,discountprice;
  int? totalcount;
  final List<String> _wordName = [
    "Buy ONE Lead",
    "Buy ALL Leads",
  ];

  var _razorpay = Razorpay();

  getSession() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      token = sp.getString('token') ?? '';
    });
    STM().checkInternet(context, widget).then((value) {
      if (value) {
        // getCity();
        totalAmount(0);
      }
    });
  }

  var v,token;

  @override
  void initState() {
    // TODO: implement initState
    controller.stream.listen(
          (dynamic event) {
          setState(() {
            discount = event['discount'].toString();
            mobileCtrl = TextEditingController(text: event['codename'].toString());
            discountprice = event['discount_price'].toString();
          });
      },
    );
    print(discountprice);
    v = widget.leaddetails;
    getSession();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    MakePayment(trans_id: response.paymentId);
    debugPrint(response.paymentId);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      //   leading:Padding(
      //     padding: EdgeInsets.all(Dim().d16),
      //     child: InkWell(
      //         onTap: (){
      //           STM().back2Previous(ctx);
      //         },
      //         child: SvgPicture.asset('assets/backbtn.svg')),
      //   ),
      //
      // ),
      key: scaffoldState,
      drawer: navBar(ctx,scaffoldState),
      // resizeToAvoidBottomInset: false,
      backgroundColor: Clr().white,
      body: SingleChildScrollView(
        child: DecoratedBox(
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/pattern.png'),fit: BoxFit.fitWidth,alignment: Alignment.topCenter)
          ),
          child: Padding(
            padding: EdgeInsets.all(Dim().d16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Dim().d36,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                        onTap: (){
                          STM().back2Previous(ctx);
                        },
                        child: SvgPicture.asset('assets/backbtn.svg',height: 20,width: 20,))),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Lead Details',
                    style: Sty().largeText.copyWith(
                        color: Clr().primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 24),
                  ),
                ) ,
                SizedBox(
                  height: Dim().d114,
                ),
                Padding(
                  padding: EdgeInsets.only(top: Dim().d8,bottom: Dim().d16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Available:-",
                          style: Sty().smallText.copyWith(
                            fontSize: 14,
                            color: Clr().primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' ${v['available']}',
                              style: Sty().smallText.copyWith(
                                  color: Clr().textColor,
                                  fontWeight: FontWeight.w600,
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
                          text: "Date:-",
                          style: Sty().smallText.copyWith(
                            fontSize: 14,
                            color: Clr().primaryColor,
                            fontWeight: FontWeight.w400,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' ${DateFormat('dd MMM yyyy').format(DateTime.parse(v['date'].toString()))}',
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
                          text: "Name:-",
                          style: Sty().smallText.copyWith(
                            fontSize: 14,
                            color: Clr().primaryColor,
                            fontWeight: FontWeight.w400,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' ${v['name'].toString()}',
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
                          text: "Location: ",
                          style: Sty().smallText.copyWith(
                            fontSize: 14,
                            color: Clr().primaryColor,
                            fontWeight: FontWeight.w400,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' ${v['city']['name'].toString()}',
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          height: 40,
                          width: 250,
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: 2,
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 40,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 1,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectedIndex = index;
                                    totalAmount(index);
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    _selectedIndex == index
                                        ? SvgPicture.asset(
                                        'assets/slectdrop2.svg')
                                        : SvgPicture.asset(
                                        'assets/selectDrop.svg'),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 6),
                                      child: Text(_wordName[index],
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dim().d16,
                      ),
                      SizedBox(
                        height: Dim().d52,
                        child: TextFormField(
                          controller: mobileCtrl,
                          keyboardType: TextInputType.text,
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return 'This field is required';
                          //   }
                          //   if (value.length != 10) {
                          //     return 'Mobile number digits must be 10';
                          //   }
                          // },
                          decoration: InputDecoration(
                            fillColor: Clr().lightGrey,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                                borderSide: BorderSide(color: Clr().red,)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Clr().primaryColor, width: 1.1),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            contentPadding: EdgeInsets.only(left: 20),
                            // label: Text('Enter Your Number'),
                            hintText: "Enter Coupon Code",
                            suffixIcon: InkWell(onTap: (){
                              mobileCtrl.text.isEmpty ? STM().displayToast('Enter Coupon Code') : getCoupanList();
                            },
                              child: Padding(
                                padding:  EdgeInsets.all(16.0),
                                child: Text('Apply',style: Sty().smallText.copyWith(
                                    color: Clr().textColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15)),
                              ),
                            ),
                            // suffix: Text('Apply'),
                            // labelText: 'Mobile Number',
                            labelStyle: TextStyle(color:Clr().textColor),
                            hintStyle: Sty().mediumText.copyWith(
                              color: Clr().textColor,
                            ),
                            counterText: "",
                          ),
                          maxLength: 10,
                        ),
                      ),
                      SizedBox(height: Dim().d4,),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                // downloadInv();
                                STM().redirect2page(ctx, CouponCode(amount: totalcount,));
                              },
                              child: Text(
                                'View All Coupons',
                                style: Sty().smallText.copyWith(
                                    height: 1.2,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Clr().primaryColor),
                              ),
                            ),
                            Text(
                              '___________',
                              style: Sty().smallText.copyWith(
                                  height: 0.1,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff28282A)),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: Dim().d20,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Cost Per Lead:-",
                          style: Sty().smallText.copyWith(
                            fontSize: 14,
                            color: Clr().primaryColor,
                            fontWeight: FontWeight.w400,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '₹ ${v['lead_cost'].toString()}',
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
                          text: "Coupon Discount:-",
                          style: Sty().smallText.copyWith(
                            fontSize: 14,
                            color: Clr().primaryColor,
                            fontWeight: FontWeight.w400,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' ₹ ${discount == null ? 0: discount}',
                              style: Sty().smallText.copyWith(
                                  color: Clr().textColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Dim().d16),
                      Row(
                        children: [
                          SizedBox(
                            height: Dim().d44,
                            child: Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35),side: BorderSide(width: 1, color: Clr().primaryColor)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: Dim().d12),
                                child: Center(
                                  child: RichText(
                                    text: TextSpan(
                                      text: "Total Amount:-",
                                      style: Sty().smallText.copyWith(
                                        fontSize: 14,
                                        color: Clr().primaryColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ' ₹ ${discount ?? totalcount}',
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
                      ),
                      SizedBox(height: Dim().d16),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: Dim().d40,
                          width: Dim().d180,
                          child: ElevatedButton(
                              onPressed: () {
                                var totalprice;
                                if(discount == null){
                                  var total = totalcount;
                                  totalprice = total! * 100;
                                }else{
                                  var total = int.parse(discount!) * 100;
                                  totalprice = total;
                                }
                                var options = {
                                  'key': 'rzp_test_fT7N8Y0fzEEHjO',
                                  'amount': '${totalprice.toString()}',
                                  //in the smallest currency sub-unit.
                                  'name': 'ZoomingHome',
                                  // 'order_id': 'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
                                  'order': {
                                    "id": DateTime.now().millisecondsSinceEpoch.toString(),
                                    "entity": "order",
                                    "amount": '${totalprice.toString()}',
                                    "amount_paid": 0,
                                    "amount_due": '${totalprice.toString()}',
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
                                  // in seconds
                                  // 'prefill': {
                                  //   'contact': '',
                                  //   'email': ''
                                  // }
                                };
                                _razorpay.open(options);
                                print('${totalprice}WEGRHGR');
                                // MakePayment();
                              },
                              style: ElevatedButton.styleFrom(
                                  elevation: 0.5,
                                  backgroundColor: Clr().primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(35))),
                              child: Text(
                                'Make Payment',
                                style: Sty().mediumText.copyWith(
                                    fontSize: 16,
                                    color: Clr().secondaryColor, fontWeight: FontWeight.w400),
                              )),
                        ),
                      ),
                      SizedBox(height: Dim().d16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void MakePayment({trans_id}) async {
    FormData body = FormData.fromMap({
      'lead_id': v['id'],
      'no_of_leads': _selectedIndex == 0 ? 1 : v['available'],
      'coupon_code': mobileCtrl.text,
      'coupon_discount': discountprice ?? 0,
      'total_amount': discount ?? totalcount,
      'paid_amount': discount ?? totalcount,
      'transaction_id': trans_id,
    });
    var result = await STM().posttoken(ctx, Str().processing, 'buyLead', body, token);
    var status = result['success'];
    var message = result['message'];
    if(status){
     STM().successDialogWithAffinity(ctx, message, LeadDetails2(details: result['data'],leaddetails: widget.leaddetails,));
    }else{
      STM().errorDialog(ctx, message);
    }
  }


  // coupanList
  void getCoupanList() async {
    List<dynamic> coupanList = [];
    var result = await STM().get(ctx, Str().loading, 'coupon_list');
    var status = result['status'];
    if(status){
      setState(() {
        coupanList = result['data'];
      });
      for(int a = 0; a < coupanList.length;a++) {
        if (coupanList.map((e) => e['coupon_code']).contains(mobileCtrl.text)) {
          applyCoupans(list: coupanList,index: a);
        }else{
          STM().errorDialog(ctx, 'This coupon code is expire or not applicable');
        }
      }
    }
  }

  void applyCoupans({list,index}) async {
    FormData body = FormData.fromMap({
      'coupon_code': mobileCtrl.text,
      'amount': totalcount,
    });
    var result = await STM().posttoken(ctx, Str().processing, 'apply_coupon', body,token);
    var status = result['status'];
    if(status){
      setState(() {
        discount = result['data'].toString();
        discountprice = list[index]['coupon_flat_discount'].toString();
        print(discount);
        print(discountprice);
      });
      // BuyLeadpage.controller.sink.add({
      //   'codename': code,
      //   'discount': result['data'],
      //   'discount_price': duscountprice,
      // });
    }
  }

  void totalAmount(index){
    int leadcost = int.parse(v['lead_cost'].toString());
    int available = v['available'];
    if(index == 1) {
      setState(() {
        mobileCtrl.clear();
        discount = null;
        totalcount = leadcost * available;
      });
    }else{
      mobileCtrl.clear();
      discount = null;
      totalcount = leadcost;
    }
  }

}
