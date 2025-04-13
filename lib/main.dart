import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Add this import
import 'package:med_sync/features/application/provider/medicine_provider.dart';
import 'package:med_sync/features/domain/model/medicine_model.dart';
import 'package:med_sync/presentation/screens/home_page_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  
  // Register Hive adapters
  Hive.registerAdapter(MedicineAdapter()); // Add this after creating the adapter
    Hive.registerAdapter(MedicineTypeAdapter());
  // Open the medicines box
  await Hive.openBox<Medicine>('medicines');
  

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          
            create: (_) => MedicineProvider()..loadMedicines(), )
         // create: (_) => MedicineProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}