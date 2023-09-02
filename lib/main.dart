import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("CV Page"),
        ),
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                      child: Row(
                        children: [
                          Container(
                            width: 80.0,
                            child: Image.network(
                                "https://i.pinimg.com/236x/a1/01/7d/a1017da97b51b5190b674ca23dbed210.jpg"),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                      child: Row(
                        children: [
                          Text("Name: "),
                          SizedBox(
                            width: 25,
                          ),
                          Text("Fatma Ahmed Hammad"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                      child: Row(
                        children: [
                          Text("Phone: "),
                          SizedBox(
                            width: 25,
                          ),
                          Text("01234567890"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red, // foreground
                        ),
                        onPressed: () {
                          print("Successfully, calling");
                        },
                        child: Text("Call me"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}
