import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

// معلومات الاتصال الخاصة بك
const String _wssUrl = 'wss://1765.3cx.cloud:443/ws'; // قد تحتاج لتجربة مسارات مختلفة هنا
const String _sipUri = 'sip:16410@1765.3cx.cloud';
const String _authId = '16410';
const String _password = 'posbank12@P';

class WebrtcSipClient {
  WebSocket? _socket;

  // 1. إنشاء الاتصال الأولي (WebSocket)
  Future<void> connect() async {
    try {
      // قم بإجراء اتصال WebSocket آمن
      _socket = await WebSocket.connect(_wssUrl, protocols: ['sip']);

      print('WebSocket connected to $_wssUrl');

      // ابدأ الاستماع للرسائل الواردة من الخادم
      _socket!.listen(_onMessage, onDone: () => print('WebSocket disconnected'), onError: (error) => print('WebSocket error: $error'), cancelOnError: true);

      // الآن يجب عليك إرسال رسالة REGISTER عبر هذا الاتصال
      _sendRegister();
    } catch (e) {
      print('Connection failed: $e');
      // إذا فشل هذا، قد تكون المشكلة في المسار، جرب مسارات WSS الأخرى هنا!
    }
  }

  // 2. إرسال رسالة SIP REGISTER (منطق SIP)
  void _sendRegister() {
    if (_socket?.readyState == WebSocket.open) {
      final registerMessage =
          '''
REGISTER $_sipUri SIP/2.0
Via: SIP/2.0/WS some_client_host;rport;branch=z9hG4bK-flutter-webrtc
Max-Forwards: 70
To: <$_sipUri>
From: <$_sipUri>;tag=some_tag
Call-ID: some_call_id
CSeq: 1 REGISTER
Contact: <sip:$_authId@some_ip;transport=ws>;expires=3600
Authorization: Digest username="16410", realm="1765.3cx.cloud", uri="$_sipUri", response="placeholder"
Content-Length: 0
''';
      // ملاحظة: هذا مجرد هيكل رسالة. يجب عليك حساب الحقول (مثل Branch و Call-ID و Response)
      // وفقًا لمعيار SIP/Digest Authentication.

      _socket!.add(registerMessage);
      print('Sent REGISTER message');
    }
  }

  // 3. معالجة الرسائل الواردة
  void _onMessage(dynamic message) {
    print('Received SIP Message:\n$message');

    // هنا يجب عليك تحليل الرد (مثلاً، إذا كان 401 Unauthorized، قم بحساب مفتاح الهاش Digest وإرسال رسالة REGISTER جديدة).
  }
}

// مثال على الاستخدام:
// WebrtcSipClient().connect();
