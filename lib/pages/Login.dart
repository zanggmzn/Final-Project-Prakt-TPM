// ignore: file_names
import 'package:flutter/material.dart';
import 'package:projekakhir_prakt/pages/PageListTeam.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final String user = 'user';
  final String pass = 'user123';

  TextEditingController cUser =
      TextEditingController(); // ambil nilai fill user
  TextEditingController cPass = TextEditingController(); // ambil nilai fill pas

  late SharedPreferences prefs; //menginstansiasi sharedpref di lain tempat
  //jadi shared pref harus deklar di functuon yg asin

  @override
  void initState() {
    //gunanya utk menjalankan smwa fungsi saat pertama kali app dirun
    super.initState();
    checkIsLogin();
  }

  //panggil checkislogin didlm initstate
  void checkIsLogin() async {
    //ngecek pernah login ap blom
    prefs = await SharedPreferences.getInstance();
    bool? isLogin = (prefs.getString('datauser') != null) ? true : false;
    //jadi kalo username != null true bisa langsung masuk ke homepage
    //alias kalo dah ada data username maka langsung ke homepage

    //jadi sharedpref masuk sini krn buat ngecek, misal gada data username ya harus login sek
    //kalo ada data sharedpref biar bisa langsung masuk
    if (isLogin && mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const PageListTeam()),
        (route) => false,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    cUser.dispose();
    cPass.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xfff0f1f5),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
        padding: const EdgeInsets.all(18),
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 300,
              child: RichText(
                  text: const TextSpan(
                      text: 'NBA ROSTER',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 32,
                        color: Color.fromARGB(255, 117, 33, 243),
                        fontWeight: FontWeight.bold,
                      ),
                      children: <TextSpan>[
                    TextSpan(
                        text: '\nWelcome!',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black87,
                            fontSize: 24))
                  ])),
            ),
            SizedBox(
              width: size.width,
              height: size.height * 0.37,
              child: Image.asset('images/watch.png'),
            ),
            Container(
              height: size.height * .26,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.2),
                      spreadRadius: 2,
                      blurRadius: 20,
                      offset: const Offset(0, 0),
                    )
                  ]),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Positioned(
                    top: 10,
                    left: 20,
                    child: Text(
                      'Login Here',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Positioned(
                      top: 50,
                      left: 20,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.person,
                                color: Colors.grey,
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 10),
                                width: 300,
                                child: TextField(
                                  controller: cUser,
                                  cursorColor: Colors.grey,
                                  style: const TextStyle(
                                    color: Colors.black54,
                                  ),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Username',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: size.width * .8,
                            child: const Divider(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )),
                  Positioned(
                      top: 120,
                      left: 20,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.key,
                                color: Colors.grey,
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 10),
                                width: 300,
                                child: TextField(
                                  controller: cPass,
                                  cursorColor: Colors.grey,
                                  style: const TextStyle(
                                    color: Colors.black54,
                                  ),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Password',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: size.width * .8,
                            child: const Divider(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )),
                  Positioned(
                    bottom: -30,
                    right: 30,
                    child: Container(
                      padding: const EdgeInsets.all(22),
                      height: 80,
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () async {
                          checkLogic(context);
                        },
                        child: const Text('L O G I N'),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 117, 33, 243),
                        ),
                      ),
                      //child: Image.asset('assets/right-arrow.png'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ))),
    );
  }

  void checkLogic(BuildContext context) async {
    if (cUser.text == user && cPass.text == pass) {
      await prefs.setString('datauser', user);
      if (mounted) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const PageListTeam(),
            ));
        //snackbar itu pop up dr bawah
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login Berhasil!'),
            backgroundColor: Colors.blue,
          ),
        );
      }
    } else if (cUser.text.isEmpty || cPass.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username atau Password Harus Diisi!'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username dan Password Anda Salah!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
