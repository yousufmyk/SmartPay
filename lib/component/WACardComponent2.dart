import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:mobile_banking/model/WalletAppModel.dart';
import 'package:mobile_banking/screen/WASendMoneyViaLoopScreen.dart';
import 'package:http/http.dart' as http;
import '../dashboard/limit_fragment.dart';
import '../model/Api Service/Balance Api/checkBalanceApi.dart';
import '../model/cardDetailsModel.dart';
import '../screen/WAPinScreen.dart';
import '../screen/WAPinScreenForSecondCard.dart';

class WACardComponent2 extends StatefulWidget {
  static String tag = '/WACardComponent';
  final WACardModel2? cardModel2;
  final CreditCardModel data;

  WACardComponent2({this.cardModel2, required this.data});

  @override
  WACardComponent2State createState() => WACardComponent2State(data: data);
}

class WACardComponent2State extends State<WACardComponent2> {
  WACardComponent2State({
    required this.data,
  }) : assert(data != null);
  final CreditCardModel data;

  List<bool> _selections = List.generate(3, (_) => false);
  var TxtBold = FontWeight.normal;
  var TxtItalic = FontStyle.normal;
  var TxtUnder = TextDecoration.none;
   var cardStatus = "";

  bool isSwitched = false;
  var textValue = 'Switch is OFF';

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        textValue = 'Switch Button is ON';
        cardStatus = "Blocked";
      });
     
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched = false;
        textValue = 'Switch Button is OFF';
        cardStatus = "Unblocked";
      });
     
      print('Switch Button is OFF');
    }
  }

  bool newIcon = true;
  bool initialPosition = true;
  

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 10, top: 8),
      decoration: boxDecorationRoundedWithShadow(
    30,
    backgroundColor: widget.cardModel2!.color!,
    blurRadius: 10.0,
    spreadRadius: 4.0,
    shadowColor: widget.cardModel2!.color!.withAlpha(50),
      ),
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
              data.cardOrderInfo!.secondaryCardOrderInfo!
                  .elementAt(0)
                  .nameOnCard!
                  .toUpperCase(),
              //"Secondary",
              style: primaryTextStyle(color: Colors.white70)),
          Align(
            alignment: Alignment.topRight,
            child: ImageIcon(
              AssetImage('images/mobile_banking/wa_visa.png'),
              size: 50,
              color: Colors.white,
            ),
          ),
        ],
      ),
      Text('Balance', style: secondaryTextStyle(color: Colors.white60)),
      2.height,
      CheckBalanceApiService(),

      2.height,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
              data.cardOrderInfo!.secondaryCardOrderInfo!
                  .elementAt(0)
                  .card!
                  .toUpperCase(),
              style: primaryTextStyle(color: Colors.white70)),
          Text(
              data.cardOrderInfo!.secondaryCardOrderInfo!
                  .elementAt(0)
                  .expiryDate!
                  .toUpperCase(),
              style: primaryTextStyle(color: Colors.white70)),
        ],
      ),

      Divider(thickness: 1),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
              onTap: () {
                WAPinScreenSecondCard(
                  data: data,
                ).launch(context);
              },
              child: Text("Pin",
                  style: primaryTextStyle(color: Colors.white70))),
          GestureDetector(
              onTap: () {
                LimitFragment(
                  data: data,
                ).launch(context);
              },
              child: Text("Limits",
                  style: primaryTextStyle(color: Colors.white70))),
          Switch(
            onChanged: toggleSwitch,
            value: isSwitched,
            activeColor: Colors.red,
            activeTrackColor: Colors.white,
            inactiveThumbColor: Colors.green,
            inactiveTrackColor: Colors.white,
          ),

           Text("${cardStatus}",
                      style: primaryTextStyle(color: Colors.white70)),
        ],
      )
     
    ],
      ),
    ).onTap(() {
     
    });
  }
}
