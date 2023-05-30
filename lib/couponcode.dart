import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoominghome/buylead.dart';
import 'package:zoominghome/sidedrawer.dart';
import 'package:zoominghome/values/strings.dart';
import 'leaddetails2.dart';
import 'manage/static_method.dart';
import 'otp.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

class CouponCode extends StatefulWidget {
  final int? amount;
  const CouponCode({super.key,this.amount});

  @override
  State<CouponCode> createState() => _CouponCodeState();
}

class _CouponCodeState extends State<CouponCode> {
  late BuildContext ctx;
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  String? Token;
  List<dynamic> coupanList = [];

  getSession() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      Token = sp.getString('token') ?? '';
    });
    STM().checkInternet(context, widget).then((value) {
      if (value) {
        getCoupanList();
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
      key: scaffoldState,
      drawer: navBar(ctx,scaffoldState),

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
                    'Coupon Code',
                    style: Sty().largeText.copyWith(
                        color: Clr().primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 24),
                  ),
                ) ,
                SizedBox(
                  height: Dim().d110,
                ),

                ListView.builder(
                  padding: EdgeInsets.only(top: Dim().d16,bottom:Dim().d16 ),
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: coupanList.length,
                  itemBuilder: (context, index) {
                      return Card(
                        elevation: 0,
                        margin:  EdgeInsets.only(bottom: 15),
                        shape:  RoundedRectangleBorder(
                          side: BorderSide(color: Colors.grey,width:0.4),
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        color: const Color(0xffFFFFFF),
                        child:Padding(
                          padding: EdgeInsets.all(Dim().d16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                // crossAxisAlignment: CrossAxisAlignment.spaceBetween,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset('assets/coupan.svg'),
                                      SizedBox(width: Dim().d4,),
                                      Text('${coupanList[index]['coupon_code'].toString()}', style: Sty().smallText.copyWith(
                                          color: Clr().textColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Dim().d8,width:Dim().d16 ),
                                  Padding(
                                    padding:  EdgeInsets.only(left: 24.0),
                                    child: Text('Pay with visa card to avail the offer ', style: Sty().smallText.copyWith(
                                        color: Clr().textColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Dim().d32,
                                width: Dim().d80,
                                child: ElevatedButton(
                                    onPressed: () {
                                      applyCoupans(code: coupanList[index]['coupon_code'].toString(),duscountprice: coupanList[index]['coupon_flat_discount'].toString());
                                    },
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0.5,
                                        backgroundColor: Clr().primaryColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(35))),
                                    child: Text(
                                      'Apply',
                                      style: Sty().mediumText.copyWith(
                                          fontSize: 12,
                                          color: Clr().secondaryColor, fontWeight: FontWeight.w400),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // coupanList
void getCoupanList({code,duscountprice}) async {
    var result = await STM().get(ctx, Str().loading, 'coupon_list');
    var status = result['status'];
    if(status){
      setState(() {
        coupanList = result['data'];
      });
    }
}

void applyCoupans({code,duscountprice}) async {
    FormData body = FormData.fromMap({
    'coupon_code': code,
    'amount': widget.amount,
    });
    var result = await STM().posttoken(ctx, Str().processing, 'apply_coupon', body,Token);
    var status = result['status'];
    if(status){
        BuyLeadpage.controller.sink.add({
          'codename': code,
          'discount': result['data'],
          'discount_price': int.parse(widget.amount.toString()) - int.parse(result['data'].toString()),
        });
        print(duscountprice);
        STM().back2Previous(ctx);
    }
}


}
