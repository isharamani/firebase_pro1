import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_pro1/loginsignin/Signup.dart';
import 'package:firebase_pro1/loginsignin/homepage.dart';
import 'package:firebase_pro1/task/authscreen.dart';
import 'package:firebase_pro1/task2/authscreen.dart';
import 'package:firebase_pro1/task2/paytmscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stripe_payment/stripe_payment.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDQe1JhH8PrT3MW7cO01nSYT3z0R_sB324",
          appId: "1:167500226312:android:f483639cc549e5612056bd",
          messagingSenderId: "167500226312",
          projectId: "fir-pro1-3a3b5")
           );
  StripePayment.setOptions(
    StripeOptions(
      publishableKey: "your_stripe_publishable_key",
      merchantId: "Test",
      androidPayMode: 'test',
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',

      home:PaymentScreen(),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Delivery Validation App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   DateTime? _collectionDate;
//   String? _collectionTimeSlot;
//   DateTime? _deliveryDate;
//   String? _deliveryTimeSlot;
//
//   void _selectDate(BuildContext context, bool isCollection) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2101),
//     );
//
//     if (picked != null && picked != (isCollection ? _collectionDate : _deliveryDate)) {
//       setState(() {
//         if (isCollection) {
//           _collectionDate = picked;
//           _deliveryDate = null; // Reset delivery date when collection date changes
//         } else {
//           _deliveryDate = picked;
//         }
//       });
//     }
//   }
//
//   void _selectTimeSlot(BuildContext context, bool isCollection) async {
//     final timeSlot = await showDialog<String>(
//       context: context,
//       builder: (BuildContext context) {
//         return SimpleDialog(
//           title: const Text('Select Time Slot'),
//           children: <Widget>[
//             SimpleDialogOption(
//               onPressed: () {
//                 Navigator.pop(context, 'Morning');
//               },
//               child: const Text('Morning'),
//             ),
//             SimpleDialogOption(
//               onPressed: () {
//                 Navigator.pop(context, 'Afternoon');
//               },
//               child: const Text('Afternoon'),
//             ),
//           ],
//         );
//       },
//     );
//
//     if (timeSlot != null) {
//       setState(() {
//         if (isCollection) {
//           _collectionTimeSlot = timeSlot;
//         } else {
//           _deliveryTimeSlot = timeSlot;
//         }
//       });
//     }
//   }
//
//   bool _isDeliveryDateValid() {
//     if (_collectionDate == null || _deliveryDate == null) return true;
//     return _deliveryDate!.isAfter(_collectionDate!);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Delivery Validation App'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: <Widget>[
//             ListTile(
//               title: Text('Collection Date: ${_collectionDate == null ? "Not selected" : DateFormat.yMd().format(_collectionDate!)}'),
//               subtitle: Text('Time Slot: ${_collectionTimeSlot ?? "Not selected"}'),
//               trailing: ElevatedButton(
//                 child: Text('Select'),
//                 onPressed: () {
//                   _selectDate(context, true);
//                 },
//               ),
//             ),
//             ElevatedButton(
//               child: Text('Select Time Slot'),
//               onPressed: () {
//                 _selectTimeSlot(context, true);
//               },
//             ),
//             SizedBox(height: 20),
//             ListTile(
//               title: Text('Delivery Date: ${_deliveryDate == null ? "Not selected" : DateFormat.yMd().format(_deliveryDate!)}'),
//               subtitle: Text('Time Slot: ${_deliveryTimeSlot ?? "Not selected"}'),
//               trailing: ElevatedButton(
//                 child: Text('Select'),
//                 onPressed: () {
//                   _selectDate(context, false);
//                 },
//               ),
//             ),
//             ElevatedButton(
//               child: Text('Select Time Slot'),
//               onPressed: () {
//                 _selectTimeSlot(context, false);
//               },
//             ),
//             SizedBox(height: 20),
//             if (!_isDeliveryDateValid())
//               Text(
//                 'Delivery date must be after the collection date and cannot be the same.',
//                 style: TextStyle(color: Colors.red),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
