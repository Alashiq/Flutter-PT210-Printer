// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
// import 'package:esc_pos_utils/esc_pos_utils.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Bluetooth Printer App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
//   List<BluetoothDevice> _devicesList = [];
//   BluetoothDevice? _selectedDevice;
//   BluetoothConnection? _connection;
//   bool _connected = false;

//   @override
//   void initState() {
//     super.initState();
//     FlutterBluetoothSerial.instance.state.then((state) {
//       setState(() {
//         _bluetoothState = state;
//       });
//     });

//     FlutterBluetoothSerial.instance
//         .onStateChanged()
//         .listen((BluetoothState state) {
//       setState(() {
//         _bluetoothState = state;
//       });
//     });

//     FlutterBluetoothSerial.instance
//         .getBondedDevices()
//         .then((List<BluetoothDevice> devices) {
//       setState(() {
//         _devicesList = devices;
//       });
//     });
//   }

//   void _connect() async {
//     if (_selectedDevice != null) {
//       await BluetoothConnection.toAddress(_selectedDevice!.address)
//           .then((connection) {
//         setState(() {
//           _connection = connection;
//           _connected = true;
//         });
//       }).catchError((error) {
//         setState(() {
//           _connected = false;
//         });
//       });
//     }
//   }

//   void _print() async {
//     if (_connected && _connection != null) {
//       final profile = await CapabilityProfile.load();
//       final generator = Generator(PaperSize.mm58, profile);

//       List<int> bytes = [];
//       bytes += generator.text('Hello, PT-210 Printer!',
//           styles: PosStyles(align: PosAlign.center, bold: true));

//       bytes += generator.text('تجربة طباعة بالعربي!',
//           styles: PosStyles(align: PosAlign.center, bold: true));
//       bytes += generator.cut();

//       _connection!.output.add(Uint8List.fromList(bytes));
//       await _connection!.output.allSent;

//       print("Print command sent");
//     } else {
//       print("Not connected to any device");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Bluetooth Printer App'),
//       ),
//       body: Column(
//         children: <Widget>[
//           SwitchListTile(
//             title: Text('Enable Bluetooth'),
//             value: _bluetoothState.isEnabled,
//             onChanged: (bool value) {
//               future() async {
//                 if (value) {
//                   await FlutterBluetoothSerial.instance.requestEnable();
//                 } else {
//                   await FlutterBluetoothSerial.instance.requestDisable();
//                 }
//               }

//               future().then((_) {
//                 setState(() {});
//               });
//             },
//           ),
//           ListTile(
//             title: Text('Device: ${_selectedDevice?.name ?? ''}'),
//             subtitle: Text('Address: ${_selectedDevice?.address ?? ''}'),
//           ),
//           ElevatedButton(
//             onPressed: _connect,
//             child: Text('Connect'),
//           ),
//           ElevatedButton(
//             onPressed: _print,
//             child: Text('Print'),
//           ),
//           Expanded(
//             child: ListView(
//               children: _devicesList.map((device) {
//                 return ListTile(
//                   title: Text(device.name ?? ''),
//                   subtitle: Text(device.address),
//                   onTap: () {
//                     setState(() {
//                       _selectedDevice = device;
//                     });
//                   },
//                 );
//               }).toList(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
