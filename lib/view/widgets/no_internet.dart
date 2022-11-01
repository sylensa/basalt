import 'package:basalt/view/widgets/p_button.dart';
import 'package:flutter/material.dart';
// local imports

class NoInternet extends StatelessWidget {
  final Function onTryAgainClicked;

  NoInternet({required this.onTryAgainClicked});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/no_internet.png',
              width: 200,
              height: 130,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                "You're offline.",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.red),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 32.0),
              child: Text(
                "No Internet Found. Check your connection\nor try again",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0, color: Colors.black54),
              ),
            ),
            SizedBox(
              width: 150,
              height: 40,
              child: PButton(
                  rounded: false,
                  textColor: Colors.white,
                  text: 'TRY AGAIN',
                  onPressed: () => onTryAgainClicked()),
            )
          ],
        ),
      ),
    );
  }
}
