// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class SipWebView extends StatefulWidget {
//   final String extension;
//   final String password;
//   final String server;

//   const SipWebView({Key? key, required this.extension, required this.password, required this.server}) : super(key: key);

//   @override
//   _SipWebViewState createState() => _SipWebViewState();
// }

// class _SipWebViewState extends State<SipWebView> {
//   late WebViewController _controller;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('SIP Phone')),
//       body: WebView(
//         initialUrl: 'about:blank',
//         onWebViewCreated: (WebViewController webViewController) {
//           _controller = webViewController;
//           _loadSipJs();
//         },
//         javascriptMode: JavascriptMode.unrestricted,
//       ),
//     );
//   }

//   void _loadSipJs() {
//     final htmlContent =
//         '''
// <!DOCTYPE html>
// <html>
// <head>
//     <script src="https://cdn.jsdelivr.net/npm/sip.js@0.20.0/dist/sip.min.js"></script>
// </head>
// <body>
//     <div id="status">Initializing...</div>
//     <script>
//         const server = '${widget.server}';
//         const extension = '${widget.extension}';
//         const password = '${widget.password}';

//         const configuration = {
//             uri: 'sip:' + extension + '@' + server,
//             password: password,
//             transportOptions: {
//                 wsServers: ['wss://' + server + ':5001/WSSIP']
//             },
//             register: true,
//             sessionDescriptionHandlerOptions: {
//                 constraints: {
//                     audio: true,
//                     video: false
//                 }
//             }
//         };

//         const userAgent = new SIP.UA(configuration);

//         userAgent.on('registered', function() {
//             document.getElementById('status').innerHTML = 'Registered ✅';
//         });

//         userAgent.on('registrationFailed', function() {
//             document.getElementById('status').innerHTML = 'Registration Failed ❌';
//         });

//         userAgent.on('invite', function(session) {
//             document.getElementById('status').innerHTML = 'Incoming Call 📞';
            
//             // قبول المكالمة تلقائياً
//             session.accept({
//                 sessionDescriptionHandlerOptions: {
//                     constraints: {
//                         audio: true,
//                         video: false
//                     }
//                 }
//             });
            
//             session.on('accepted', function() {
//                 document.getElementById('status').innerHTML = 'Call Connected ✅';
//             });
            
//             session.on('failed', function() {
//                 document.getElementById('status').innerHTML = 'Call Failed ❌';
//             });
            
//             session.on('ended', function() {
//                 document.getElementById('status').innerHTML = 'Call Ended 📞';
//             });
//         });

//         // بدء التسجيل
//         userAgent.start();
//     </script>
// </body>
// </html>
//     ''';

//     _controller.loadUrl(Uri.dataFromString(htmlContent, mimeType: 'text/html').toString());
//   }
// }
