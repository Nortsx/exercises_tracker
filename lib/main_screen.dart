import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:percent_indicator/percent_indicator.dart';

class _InputScreen extends StatefulWidget {
  @override
  State createState() => new _InputScreenState();
}

class _InputScreenState extends State<_InputScreen> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String userPost = '';
    return Column(children: [
      TextField(
          controller: _textController,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: "Enter",
            border: InputBorder.none,
            suffixIcon: IconButton(
              onPressed: () {
                _textController.clear();
              },
              icon: const Icon(Icons.clear),
            ),
          ),
          onSubmitted: (String text) {
            setState(() {
              userPost = text;
            });
            _textController.clear();
          },
          onChanged: (String text) {
            setState(() {});
          }),
    ]);
  }
}

class _DropDownScreen extends StatefulWidget {
  @override
  State createState() => new _DropDownScreenState();
}

class _DropDownScreenState extends State<_DropDownScreen> {
  List<String> options = <String>[
    'Sit-ups',
    'Push-ups',
  ];
  String dropDownValue = 'Sit-ups';
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: dropDownValue,
      items: options.map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        },
      ).toList(),
      onChanged: (String? newValue) {
        setState(() {
          dropDownValue = newValue!;
        });
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(248, 242, 242, 100),
      body: Stack(children: [
        Center(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 800,
              alignment: Alignment.bottomCenter,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/MainLowerBackground.png"),
                      alignment: Alignment.bottomCenter,
                      fit: BoxFit.fill)),
            ),
          ),
        ),
        Center(
            child: Align(
          alignment: Alignment(0, -1.5),
          child: Flexible(
              fit: FlexFit.loose,
              flex: 2,
              child: Container(
                height: 55.h,
                alignment: Alignment.topCenter,
                width: double.infinity,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                    image: DecorationImage(
                        image: AssetImage("assets/MainUpperBackground.png"),
                        fit: BoxFit.fitWidth)),
              )),
        )),
        Center(child: _biildNavBar()),
        Center(child: _buildTimer()),
        SafeArea(child: _buildTrainingField()),
        SafeArea(
          child: Center(child: _buildUserField()),
        ),
      ]),
    );
  }

  Widget _buildTrainingField() {
    return Align(
      alignment: Alignment(0.0, -0.7),
      child: Container(
        width: 600,
        height: 35.h,
        child: Column(
          children: [
            Align(
              alignment: Alignment(0.0, -0.6),
              child: Text(
                "Qunatity estimated",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Align(
              child: CircularPercentIndicator(
                radius: 45,
                percent: 50 / 100,
                progressColor: Color.fromARGB(181, 126, 242, 100),
                center: new Text(
                  "50/100",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Align(
                child: Container(
              width: 250,
              height: 48,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/RectangleDropdown.png"),
              )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment(0, -0.1),
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: _DropDownScreen(),
                    ),
                  ),
                  Align(
                    alignment: Alignment(1, 1),
                    child: SizedBox(
                      height: 250,
                      width: 150,
                      child: _InputScreen(),
                    ),
                  ),
                ],
              ),
            )),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildUserField() {
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
          height: 30.h,
          width: double.infinity,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            alignment: Alignment(0.5, -0.9),
                            image: AssetImage("assets/RectangleName.png")))),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 200,
                  alignment: Alignment(-0.05, -0.8),
                  child: new Text(
                    "User100",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0.88, -0.9),
                child: Container(
                  width: 45,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          alignment: Alignment(-0.2, -0.89),
                          image:
                              AssetImage("assets/free-icon-user-1946429.png"))),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildTimer() {
    return Align(
      alignment: Alignment(0, 0.55),
      child: Container(
        width: double.infinity,
        height: 36.h,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                "Time estimated",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 55,
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: CircularPercentIndicator(
                  radius: 90,
                  percent: 50 / 100,
                  progressColor: Color.fromARGB(181, 126, 242, 100),
                  center: new Text("Timer",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ))
          ],
        ),
      ),
    );
  }

  Widget _biildNavBar() {
    return Align(
        alignment: Alignment(0, 0.9),
        child: Container(
          height: 52,
          width: 269,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/MenuRectangle.png"))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image:
                      AssetImage("assets/48487c025a82eba63dea69ce02a02e0e.png"),
                  alignment: Alignment.centerLeft,
                )),
              ),
              Container(
                height: 34,
                width: 34,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/vector60-11427-01.png"),
                        alignment: Alignment.center)),
              ),
              Container(
                height: 34,
                width: 34,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/free-icon-leaderboard-4489655.png"),
                        alignment: Alignment.centerRight)),
              ),
            ],
          ),
        ));
  }
}
