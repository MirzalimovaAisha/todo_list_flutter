import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:todo_list/screens/list_screen.dart';
import 'package:todo_list/screens/login_screen.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<bool> checkLogin() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin = prefs.getBool('isLogin') ?? false;
    print("[*] isLogin:" + isLogin.toString());
    return isLogin;
  }

  @override
  void initState(){
    super.initState();
    Timer(const Duration(seconds: 0), (){
      moveScreen();
    });
  }

  void moveScreen() async{
    await checkLogin().then((isLogin) {
      if (isLogin) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ListScreen()));
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('SplashScreen', style: TextStyle(fontSize: 20),),
            Text('나만의 일정 관리 : TODO 리스트 앱', style: TextStyle(fontSize: 20),)
          ],
        ),
      ),
    );
  }
}
