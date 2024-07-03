import 'package:flutter/material.dart';

class OrderPlacedScreen extends StatelessWidget {
  const OrderPlacedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 101,
                height: 101,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(51),
                  color: const Color(0xFFE3DFFD),
                ),
                child: const Icon(
                  Icons.check_rounded,
                  size: 40,
                  color: Color.fromRGBO(128, 44, 110, 1),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Order Placed!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  // fontSize: 30,
                  // color: kSecondaryColor,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                width: 252,
                height: 65,
                child: Text(
                  'Your order was placed successfully',
                  textAlign: TextAlign.center,
                  // style: TextStyle(
                  //   fontSize: 15,
                  //   color: kSecondaryColor,
                  // ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
