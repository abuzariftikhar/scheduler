// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_qr_reader/qrcode_reader_view.dart';

// import 'CustomerFormScreen.dart';

// class ScanScreen extends StatefulWidget {
//   ScanScreen({Key? key}) : super(key: key);

//   @override
//   _ScanScreenState createState() => new _ScanScreenState();
// }

// class _ScanScreenState extends State<ScanScreen> {
//   GlobalKey<QrcodeReaderViewState> _key = GlobalKey();
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       body: QrcodeReaderView(
//         key: _key,
//         onScan: onScan,
//         headerWidget: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0.0,
//         ),
//       ),
//     );
//   }

//   Future onScan(String data) async {
//     Navigator.push(context,
//         PageRouteBuilder(pageBuilder: (context, animation, animation2) {
//       return FadeTransition(
//           opacity: animation,
//           child: SlideTransition(
//               position: Tween<Offset>(begin: Offset(0.05, 0), end: Offset(0, 0))
//                   .animate(animation),
//               child: CustomerFormScreen(
//                 data: data,
//               )));
//     }));
//     _key.currentState.startScan();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }
// }
