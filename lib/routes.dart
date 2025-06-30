// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:med_sync/features/application/provider/medicine_provider.dart';
// import 'package:med_sync/features/domain/model/medicine_model.dart';
// import 'package:med_sync/presentation/screens/add_med_screen.dart';
// import 'package:med_sync/presentation/screens/auth/welcome_screen.dart';
// import 'package:med_sync/presentation/screens/home_page_screen.dart';
// import 'package:provider/provider.dart';

// part 'routes.g.dart';

// // Route for WelcomeScreen
// @TypedGoRoute<WelcomeRoute>(path: '/welcome')
// class WelcomeRoute extends GoRouteData {
//   const WelcomeRoute();

//   @override
//   Widget build(BuildContext context, GoRouterState state) => const WelcomeScreen();
// }

// // Route for HomeScreen
// @TypedGoRoute<HomeRoute>(path: '/home')
// class HomeRoute extends GoRouteData {
//   const HomeRoute();

//   @override
//   Widget build(BuildContext context, GoRouterState state) => const HomeScreen();
// }

// // Route for AddMedicinePage
// @TypedGoRoute<AddMedicineRoute>(path: '/add-medicine')
// class AddMedicineRoute extends GoRouteData {
//   final DateTime? selectedDate;
//   final Medicine? existingMedicine;

//   const AddMedicineRoute({
//     this.selectedDate,
//     this.existingMedicine,
//   });

//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     return AddMedicinePage(
//       selectedDate: selectedDate ?? DateTime.now(),
//       existingMedicine: existingMedicine,
//     );
//   }
// }

// // Router configuration
// final goRouter = GoRouter(
//   initialLocation: '/welcome',
//   debugLogDiagnostics: true,
//   routes: $appRoutes,
//   redirect: (BuildContext context, GoRouterState state) {
//     // Placeholder: Replace with your auth logic
//     final isAuthenticated = false; // Update with actual auth check
//     if (!isAuthenticated && state.uri.toString() != '/welcome') {
//       return '/welcome';
//     }
//     return null;
//   },
//   errorBuilder: (context, state) => Scaffold(
//     body: Center(child: Text('Page not found: ${state.uri}')),
//   ),
// );