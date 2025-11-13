// import 'package:sip_ua/sip_ua.dart';

// class SipService extends SipUaHelperListener {
//   final SIPUAHelper _helper = SIPUAHelper();

//   void init() {
//     _helper.addSipUaHelperListener(this);

//     final settings = UaSettings()
//       ..webSocketUrl =
//           'wss://1765.3cx.cloud:5062' // تأكد من المنفذ الصحيح
//       ..uri = 'sip:1001@1765.3cx.cloud'
//       ..authorizationUser = '1001'
//       ..password = 'YOUR_EXTENSION_PASSWORD'
//       ..displayName = 'Eslam'
//       ..userAgent = 'Flutter SIP Client';

//     _helper.start(settings);
//   }

//   void makeCall(String targetExtension) {
//     _helper.call('sip:$targetExtension@1765.3cx.cloud');
//   }

//   @override
//   void callStateChanged(Call call, CallState state) {
//     print('Call state changed: ${state.state}');
//   }

//   @override
//   void registrationStateChanged(RegistrationState state) {
//     print('Registration: ${state.state}');
//   }
// }
