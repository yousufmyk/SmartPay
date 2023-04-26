import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;

import '../../model/CardsLimitModel.dart';



/*=======================================================================================================================================================


This transaction amount limits is only  for ATM limits


==========================================================================================================================================================*/
class WACardATMLimitComponent extends StatefulWidget {
  WACardATMLimitComponent({Key? key}) : super(key: key);
  

  @override
  State<WACardATMLimitComponent> createState() => _WACardATMLimitComponentState();
}

class _WACardATMLimitComponentState extends State<WACardATMLimitComponent> {
  @override
  Widget build(BuildContext context) {
    return LimitsContainer(currentSliderValue: 1000,);
  }
}

class LimitsContainer extends StatefulWidget {
  LimitsContainer({
    Key? key,
    required double currentSliderValue,
  });

  @override
  State<LimitsContainer> createState() => _LimitsContainerState();
}

class _LimitsContainerState extends State<LimitsContainer> {
  Future<CardLimitsModel> getCardLimit() async {
    
    const token =
        "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ7XCJpbnN0SWRcIjpcIk9NQVwiLFwidXNlck5hbWVcIjpcInlvdXN1ZjFcIixcInBhc3N3b3JkXCI6XCI1YmFhNjFlNGM5YjkzZjNmMDY4MjI1MGI2Y2Y4MzMxYjdlZTY4ZmQ4XCIsXCJwaW5cIjpcIjcxMTBlZGE0ZDA5ZTA2MmFhNWU0YTM5MGIwYTU3MmFjMGQyYzAyMjBcIixcInJvbGVcIjpcIk1FUkNIQU5UXCIsXCJkZXZpY2VUeXBlXCI6XCJNT0JJTEVcIixcImFwcGxpY2F0aW9uQWNjZXNzXCI6bnVsbCxcImV4cGlyYXRpb25UaW1lXCI6NDMyMDAsXCJtb2JpbGVDb3VudHJ5Q29kZVwiOlwiKzkxXCIsXCJtb2JpbGVOdW1iZXJcIjpcIjk2MDA1Mjc0OTJcIixcImVtYWlsSWRcIjpcInlvdXN1ZjFAb21hZW1pcmF0ZXMuY29tXCIsXCJjdXN0SWRcIjpcIjAwMDAwMDAwMDAxMTFcIixcIndhbGxldElkXCI6bnVsbCxcImFjY291bnROdW1iZXJcIjpudWxsLFwiY2FyZFJlZmVyZW5jZU51bWJlclwiOm51bGx9IiwiZXhwIjoxNjcxMjExODQwLCJpYXQiOjE2NzExNjg2NDB9.G_On9lECNV6jC9htykk1WJxEDXU8nutp2FS0CMd9oRd8_JgUk6m_oJ0gPyYR92iPNYVmiUbwbSy27I4n4ANVSw";
    final response = await http.get(
      Uri.parse(
          'http://sandboxdev.omaemirates.com:9501/NanoCMS/v1/nanocms/getCardLimit/OMA/OMA0000000000280'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return CardLimitsModel.fromJson(data);
    } else {
      return CardLimitsModel.fromJson(data);
    }
  }
  double _currentSliderValue = 200;
  @override
  Widget build(BuildContext context) {
    return 
        // Text("For ATM :", style: boldTextStyle(size: 18, color: black)),
        FutureBuilder<CardLimitsModel>(
          future: getCardLimit(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
                      return Container(
          
          decoration: BoxDecoration(
          
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Set your limtit :",
                    style: boldTextStyle(size: 18, color: black)),
                Slider(
                  activeColor: Colors.blue,
                  value: _currentSliderValue,
                  max: 1000,
                  divisions: 20,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  },
                ),
                Text("Your current limit is:",
                    style: boldTextStyle(size: 18, color: black)),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Min: ${snapshot.data!.cardLimitInfo!.primaryLimitInfo!.atm!.minAmount!.toString()}",
                        style: boldTextStyle(size: 18, color: black)),
                    Text("Max: ${snapshot.data!.cardLimitInfo!.primaryLimitInfo!.atm!.maxAmount!.toString()}",
                        style: boldTextStyle(size: 18, color: black)),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text("Domestic Limits",
                            style: boldTextStyle(size: 18, color: black)),
                          const SizedBox(
                  height: 10,
                ),
                        Row(
                          children:  [
                            Text(
                              "Daily Limit:",
                             style: boldTextStyle(size: 18, color: black),
                            ),
                            SizedBox(width: 10),
                            Text(
                              snapshot.data!.cardLimitInfo!.primaryLimitInfo!.atm!.domesticDailyAmount!.toString(),
                             style: boldTextStyle(size: 18, color: black),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  [
                            Text(
                              "Weekly Limit:",
                              style: boldTextStyle(size: 18, color: black),
                            ),
                            SizedBox(width: 10),
                            Text(
                              snapshot.data!.cardLimitInfo!.primaryLimitInfo!.atm!.domesticWeeklyAmount!.toString(),
                              style: boldTextStyle(size: 18, color: black),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  [
                            Text(
                              "Yearly Limit:",
                              style: boldTextStyle(size: 18, color: black),
                            ),
                            SizedBox(width: 10),
                            Text(
                              snapshot.data!.cardLimitInfo!.primaryLimitInfo!.atm!.domesticYearlyAmount!.toString(),
                              style: boldTextStyle(size: 18, color: black),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text("International  Limits",
                            style: boldTextStyle(size: 18, color: black)),
                            const SizedBox(
                  height: 10,
                ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  [
                            Text(
                              "Daily Limit:",
                              style: boldTextStyle(size: 18, color: black),
                            ),
                            SizedBox(width: 10),
                            Text(
                              snapshot.data!.cardLimitInfo!.primaryLimitInfo!.atm!.internationalDailyAmount!.toString(),
                              style: boldTextStyle(size: 18, color: black),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  [
                            Text(
                              "Weekly Limit:",
                              style: boldTextStyle(size: 18, color: black),
                            ),
                            SizedBox(width: 10),
                            Text(
                              snapshot.data!.cardLimitInfo!.primaryLimitInfo!.atm!.internationalWeeklyAmount!.toString(),
                              style: boldTextStyle(size: 18, color: black),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  [
                            Text(
                              "Yearly Limit:",
                              style: boldTextStyle(size: 18, color: black),
                            ),
                            SizedBox(width: 10),
                            Text(
                              snapshot.data!.cardLimitInfo!.primaryLimitInfo!.atm!.internationalYearlyAmount!.toString(),
                              style: boldTextStyle(size: 18, color: black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(thickness: 2)
              ],
            ),
          ),
        );
                    } else {
                      return const Text('Loading');
                    }
          }
    );
      
    
  }
}
