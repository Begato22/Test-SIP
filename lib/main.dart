import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sip_ua/sip_ua.dart' show UaSettings, SIPUAHelper, SipUaHelperListener, TransportType;
import 'package:sip_ua/src/sip_ua_helper.dart';

final UaSettings settings = UaSettings();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIP Client',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'SIP Client Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> implements SipUaHelperListener {
  List<String> messages = [];

  final SIPUAHelper _helper = SIPUAHelper();

  final String _sipServer = '1653.3cx.cloud'; // PBXPublicAddr
  final String _sipPort = '5060'; // PBXSipPort
  final String _extension = '23510'; // Extension
  final String _authId = 'T9Ef7YZcFB'; // AuthID
  final String _password = 'Y9iYFCUu7r'; // AuthPass
  final String _displayName = 'Eslam';

  @override
  void initState() {
    _helper.addSipUaHelperListener(this);

    UaSettings settings = UaSettings();

    settings.uri = '$_extension@$_sipServer';
    settings.displayName = _displayName;
    settings.authorizationUser = _authId;
    settings.password = _password;
    settings.host = _sipServer;
    settings.port = _sipPort;
    settings.transportType = TransportType.TCP;
    settings.realm = "3CXPhoneSystem";
    settings.registrarServer = _sipServer;

    TcpSocketSettings tcpSocketSettings = TcpSocketSettings();
    tcpSocketSettings.allowBadCertificate = true;
    settings.tcpSocketSettings = tcpSocketSettings;

    _helper.start(settings);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: Text(widget.title)),
      body: Container(
        padding: const EdgeInsets.all(10),
        // ignore: deprecated_member_use
        color: Colors.deepPurple.withOpacity(0.2),
        child: Center(
          child: ListView.separated(
            itemBuilder: (context, index) => Center(
              child: Text(messages[index], textAlign: TextAlign.center, style: TextStyle(fontSize: 18)),
            ),
            separatorBuilder: (context, index) => Divider(color: Colors.black),
            itemCount: messages.length,
          ),
        ),
      ),
    );
  }

  @override
  void callStateChanged(Call call, CallState state) {
    setState(() {
      messages.add('Call State: ${state.state}');
      log('Call State: ${state.state}');

      switch (state.state) {
        case CallStateEnum.CALL_INITIATION:
          _handleCallInitiation(call);
          break;
        case CallStateEnum.CONNECTING:
          messages.add('🔄 Call Connecting...');
          log('🔄 Call Connecting...');
          break;
        case CallStateEnum.CONFIRMED:
          messages.add('✅ Call Connected Successfully!');
          log('✅ Call Connected Successfully!');
          break;
        case CallStateEnum.FAILED:
          messages.add('❌ Call Failed: ${state.cause}');
          log('❌ Call Failed: ${state.cause}');
          break;
        case CallStateEnum.ENDED:
          messages.add('📞 Call Ended');
          log('📞 Call Ended');
          break;
        default:
          messages.add('Call State: ${state.state}');
          log('Call State: ${state.state}');
      }
    });
  }

  @override
  void onNewMessage(SIPMessageRequest msg) {}

  @override
  void onNewNotify(Notify ntf) {}

  @override
  void onNewReinvite(ReInvite event) {}

  @override
  void registrationStateChanged(RegistrationState state) {
    setState(() {
      messages.add('Registration State Changed to ${state.state}');
      log('Registration State Changed to ${state.state}');
      messages.add('Reason: ${state.cause?.reason_phrase ?? state.cause?.cause ?? ''}');
      log('Reason: ${state.cause?.reason_phrase ?? state.cause?.cause ?? ''}');
    });
  }

  @override
  void transportStateChanged(TransportState state) {
    setState(() {
      messages.add('Transport State Changed to ${state.state}');
      log('Transport State Changed to ${state.state}');
    });
  }

  void _handleCallInitiation(Call call) {
    try {
      // إعدادات وسائط مبسطة
      Map<String, dynamic> mediaConstraints = {'audio': true, 'video': false};

      // إعدادات PeerConnection مع إعدادات SRTP بدلاً من DTLS
      Map<String, dynamic> pcConfig = {
        'sdpSemantics': 'unified-plan',
        'bundlePolicy': 'max-bundle',
        'rtcpMuxPolicy': 'require',

        // هذه الإعدادات مهمة لتفادي مشكلة DTLS
        'optional': [
          {'DtlsSrtpKeyAgreement': false}, // تعطيل DTLS-SRTP
          {'RtpDataChannels': true},
        ],

        'iceServers': [
          {
            'urls': ['stun:$_sipServer:3478', 'stun:stun.l.google.com:19302'],
          },
        ],
      };

      // إعدادات RTC constraints
      Map<String, dynamic> rtcConstraints = {
        'optional': [
          {'DtlsSrtpKeyAgreement': false}, // تعطيل DTLS
          {'googDscp': false},
        ],
        'mandatory': {},
      };

      Map<String, dynamic> options = {'mediaConstraints': mediaConstraints, 'pcConfig': pcConfig, 'rtcConstraints': rtcConstraints};

      setState(() {
        messages.add('📞 Answering call without DTLS...');
        log('📞 Answering call without DTLS...');
        call.answer(options);
      });
    } catch (e) {
      setState(() {
        messages.add('❌ Error answering call: $e');
        log('❌ Error answering call: $e');
      });
    }
  }
}
