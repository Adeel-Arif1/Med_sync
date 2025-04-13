// import 'package:flutter/material.dart';
// import 'package:med_sync/features/application/provider/medicine_provider.dart';
// import 'package:med_sync/features/domain/model/medicine_model.dart';
// import 'package:provider/provider.dart';

// class MedicineListScreen extends StatelessWidget {
//   const MedicineListScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("My Medicines")),
//       body: Consumer<MedicineProvider>(
//         builder: (context, provider, child) {
//           final medicines = provider.medicines;

//           if (medicines.isEmpty) {
//             return const Center(child: Text("No medicines added yet."));
//           }

//           return ListView.builder(
//             itemCount: medicines.length,
//             itemBuilder: (context, index) {
//               final med = medicines[index];
//               return Card(
//                 margin: const EdgeInsets.all(10),
//                 child: ListTile(
//                   leading: Icon(
//                     med.type == MedicineType.capsule ? Icons.medication : Icons.opacity,
//                     color: med.isTaken ? Colors.green : Colors.red,
//                   ),
//                   title: Text(med.name),
//                   subtitle: Text("${med.dosage} - ${med.time.format(context)}"),
//                   trailing: IconButton(
//                     icon: Icon(
//                       med.isTaken ? Icons.check_box : Icons.check_box_outline_blank,
//                       color: Colors.blue,
//                     ),
//                     onPressed: () {
//                       Provider.of<MedicineProvider>(context, listen: false).toggleMedicineTaken(med.id);
//                     },
//                   ),
//                   onLongPress: () {
//                     _showDeleteDialog(context, med.id);
//                   },
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   void _showDeleteDialog(BuildContext context, String id) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text("Delete Medicine"),
//         content: const Text("Are you sure you want to delete this medicine?"),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("Cancel"),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Provider.of<MedicineProvider>(context, listen: false).deleteMedicine(id);
//               Navigator.pop(context);
//             },
//             style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//             child: const Text("Delete", style: TextStyle(color: Colors.white)),
//           ),
//         ],
//       ),
//     );
//   }
// }
