// import 'dart:nativewrappers/_internal/vm/lib/mirrors_patch.dart';

// import 'package:sip_ua/sip_ua.dart';
// import 'package:flutter_webrtc/flutter_webrtc.dart';

// // إنشاء extension للوصول للخصائص الخاصة
// extension CallExtensions on Call {
//   dynamic getPrivate(String fieldName) {
//     try {
//       // محاولة الوصول للحقول الخاصة عبر Reflection
//       final mirror = reflect(this);
//       return mirror.getField(Symbol(fieldName)).reflectee;
//     } catch (e) {
//       print('Cannot access private field: $fieldName');
//       return null;
//     }
//   }

//   RTCSessionDescription? get remoteOffer => getPrivate('remote_offer');
//   RTCPeerConnection? get peerConnection => getPrivate('pc');
// }

// class Sip3CXPatcher {
//   static Future<void> answerCall(Call call, Map<String, dynamic> options) async {
//     try {
//       final pc = call.peerConnection;
//       final offer = call.remoteOffer;

//       if (offer != null && pc != null) {
//         // إصلاح SDP لـ 3CX
//         final fixedSdp = _fix3CXSdp(offer.sdp!);
//         final fixedOffer = RTCSessionDescription(fixedSdp, offer.type);

//         print('🔄 Setting fixed remote description...');
//         await pc.setRemoteDescription(fixedOffer);

//         // إنشاء answer
//         final answer = await pc.createAnswer();
//         await pc.setLocalDescription(answer);

//         print('✅ Call answered successfully with patched SDP');
//       } else {
//         print('❌ Cannot access peer connection or remote offer');
//         // Fallback إلى الطريقة العادية
//         call.answer(options);
//       }
//     } catch (e) {
//       print('❌ Error in patched answer: $e');
//       // Fallback إلى الطريقة العادية
//       call.answer(options);
//     }
//   }

//   static String _fix3CXSdp(String sdp) {
//     print('🔧 Fixing 3CX SDP...');

//     // إذا لم يكن هناك DTLS fingerprint، أضف واحداً وهمياً
//     if (!sdp.contains('a=fingerprint:')) {
//       sdp = sdp.replaceFirst('a=setup:actpass', 'a=setup:actpass\r\na=fingerprint:sha-256 00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00');
//       print('✅ Added DTLS fingerprint to SDP');
//     }

//     // إضافة crypto line إذا كان مفقوداً
//     if (!sdp.contains('a=crypto:')) {
//       sdp = sdp.replaceFirst('m=audio', 'a=crypto:1 AES_CM_128_HMAC_SHA1_80 inline:0000000000000000000000000000000000000000\r\nm=audio');
//       print('✅ Added crypto line to SDP');
//     }

//     return sdp;
//   }
// }
