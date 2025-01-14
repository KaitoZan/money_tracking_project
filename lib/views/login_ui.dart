
import 'package:flutter/material.dart';
import 'package:money_tracking_project/models/user.dart';
import 'package:money_tracking_project/services/call_api.dart';
import 'package:money_tracking_project/views/home_ui.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  TextEditingController userNameCtrl = TextEditingController(text: '');
  TextEditingController userPasswordCtrl = TextEditingController(text: '');
  bool passStatus = true;
  showWaringDialog(context, msg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Align(
          alignment: Alignment.center,
          child: Text(
            'คำเตือน',
          ),
        ),
        content: Text(
          msg,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'ตกลง',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 74, 179, 172),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.065,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      '       เข้าใช้งาน Money Tracking',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 50,
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 1,
                        height: MediaQuery.of(context).size.height * 0.823,
                        decoration: BoxDecoration(
                          color: Colors.white, // Main Color
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(30)),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 90),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/images/money.png',
                              width: MediaQuery.of(context).size.width * 0.45,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.1,
                            right: MediaQuery.of(context).size.width * 0.1,
                            top: MediaQuery.of(context).size.height * 0.015,
                          ),
                          child: TextField(
                            controller: userNameCtrl,
                            decoration: InputDecoration(
                              labelText: 'ชื่อผู้ใช้',
                              labelStyle: TextStyle(
                                color: Color.fromARGB(255, 74, 179, 172),
                              ),
                              hintText: 'ป้อนชื่อผู้ใช้',
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 74, 179, 172),
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 74, 179, 172),
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.1,
                            right: MediaQuery.of(context).size.width * 0.1,
                            top: MediaQuery.of(context).size.height * 0.025,
                          ),
                          child: TextField(
                            controller: userPasswordCtrl,
                            obscureText: passStatus,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    passStatus = !passStatus;
                                  });
                                },
                                icon: Icon(
                                  passStatus == true
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                              labelText: 'รหัสผ่าน',
                              labelStyle: TextStyle(
                                color: Color.fromARGB(255, 74, 179, 172),
                              ),
                              hintText: 'ป้อนรหัสผ่าน',
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 74, 179, 172),
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 74, 179, 172),
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.1,
                            right: MediaQuery.of(context).size.width * 0.1,
                            top: MediaQuery.of(context).size.height * 0.03,
                            bottom: MediaQuery.of(context).size.height * 0.02,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              if (userNameCtrl.text.trim().length == 0) {
                                showWaringDialog(context, 'ป้อนชื่อผู้ใช้ด้วย');
                              } else if (userPasswordCtrl.text.trim().length == 0) {
                                showWaringDialog(context, 'ป้อนรหัสผ่านด้วย');
                              } else {
                                User user = User(
                                  userName: userNameCtrl.text.trim(),
                                  userPassword: userPasswordCtrl.text.trim(),
                                );
                                CallAPI.callcheckPassAPI(user).then((value) {
                                  if (value.message == '1') {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomeUI(user: value,),
                                      ),
                                    );
                                  } else {
                                    showWaringDialog(
                                        context, "ชื่อผู้ใช้รหัสผ่านไม่ถูกต้อง");
                                  }
                                });
                              }
                            },
                            child: Text(
                              'เข้าใช้งาน',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 74, 179, 172),
                              fixedSize: Size(
                                MediaQuery.of(context).size.width * 0.8,
                                MediaQuery.of(context).size.height * 0.07,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
