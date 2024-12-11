
import 'package:flutter/material.dart';
import 'package:money_tracking_project/views/login_ui.dart';
import 'package:money_tracking_project/views/register_ui.dart';

class WelcomeUI extends StatefulWidget {
  const WelcomeUI({super.key});

  @override
  State<WelcomeUI> createState() => _WelcomeUIState();
}

class _WelcomeUIState extends State<WelcomeUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/bg.png',
                      width: MediaQuery.of(context).size.width * 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 115),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/money.png',
                        width: MediaQuery.of(context).size.width * 0.75,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                '       บันทึก\nรายรับรายจ่าย',
                style: TextStyle(
                  color: Color.fromARGB(255, 74, 179, 172),
                  fontSize: 30.0,
                ),
              ),
              SizedBox(
              height: MediaQuery.of(context).size.height * 0.035,
            ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginUI(),
                          ),
                        );
                },
                child: Text(
                  'เริ่มใช้งานแอปพลิเคชัน',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.height * 0.020,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 74, 179, 172),
                  fixedSize: Size(
                    MediaQuery.of(context).size.width * 0.8,
                    MediaQuery.of(context).size.height * 0.07,
                  ),
                ),
              ),
              SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ยังไม่ได้ลงทะเบียน?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.height * 0.015,
                  ),
                ),
                TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterUI(),
                          ),
                        );
                      },
                      child: Text(
                        'ลงทะเบียนผู้ใช้ใหม่',
                        style: TextStyle(
                          color: Color.fromARGB(255, 74, 179, 172),
                          fontSize: MediaQuery.of(context).size.height * 0.015,
                        ),
                      ),
                    ),
              ],
            ),
            ],
          ),
        ));
  }
}
