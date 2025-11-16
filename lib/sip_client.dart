// import 'package:linphone_flutter_plugin/linphoneflutterplugin.dart';

// class LinphoneService {
//   Future<void> init() async {
//     await LinphoneFlutterPlugin.initialize();
//     LinphoneFlutterPlugin.setLogLevel(LinphoneLogLevel.debug);
//   }

//   Future<void> registerAccount({required String username, required String password, required String domain}) async {
//     await LinphoneFlutterPlugin.createAccount(username: username, password: password, domain: domain, transport: 'udp', displayName: 'Eslam Nour Eldeen');
//   }

//   Future<void> makeCall(String targetExtension) async {
//     String sipUri = 'sip:$targetExtension@$domain';
//     await LinphoneFlutterPlugin.invite(sipUri);
//   }

//   Future<void> acceptCall() async {
//     await LinphoneFlutterPlugin.acceptCall();
//   }

//   Future<void> hangupCall() async {
//     await LinphoneFlutterPlugin.terminateCall();
//   }
// }
