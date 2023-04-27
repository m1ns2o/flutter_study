import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:inflearn/common/const/colors.dart';
import 'package:inflearn/common/const/data.dart';
import 'package:inflearn/common/layout/default_layout.dart';
import 'package:inflearn/common/view/root_tab.dart';
import 'package:inflearn/user/view/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // initStatestte에는 await 작성불가 -> 함수 따로 뺴서 비동기 처리
    checkToken();
  }

  void checkToken() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final dio = Dio();

    try {
      final resp = await dio.post(
        'http://$ip/auth/token',
        options: Options(
          headers: {
            'authorization': 'Bearer $refreshToken',
          },
        ),
      );

      await storage.write(
          key: ACCESS_TOKEN_KEY, value: resp.data['accessToken']);

      // await storage.write(
      //     key: ACCESS_TOKEN_KEY, value: res.data['accessToken']);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => RootTab(),
          ),
          (route) => false);
    } catch (e) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => LoginScreen(),
          ),
          (route) => false);
    }
  }

  void deleteToken() async {
    await storage.deleteAll();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        backgroundColor: PRIMARY_COLOR,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'asset/img/logo/logo.png',
                width: MediaQuery.of(context).size.width / 2,
              ),
              SizedBox(
                height: 16,
              ),
              CircularProgressIndicator(
                color: Colors.white,
              )
            ],
          ),
        ));
  }
}
