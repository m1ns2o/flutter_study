import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';
final storage = FlutterSecureStorage();

final emulatorIp = '127.0.0.1:3000'; // 안드로이드 ip
final simulatorIp = '127.0.0.1:3000'; // ios ip

final ip = Platform.isIOS ? simulatorIp : emulatorIp;
