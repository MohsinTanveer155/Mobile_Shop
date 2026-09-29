import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/firebase_service.dart';
import '../services/payment_service.dart';
import '../services/pos_service.dart';
import '../services/warranty_service.dart';
import '../services/bundle_service.dart';
import '../services/communication_service.dart';

export 'auth_provider.dart';
export 'notification_provider.dart';
export 'staff_provider.dart';
export 'attendance_provider.dart';
export 'leave_provider.dart';
export 'salary_provider.dart';
export 'salary_request_provider.dart';

final posServiceProvider = FutureProvider<PosService>((ref) async {
  // Prevents this provider from disposing when no widget is listening,
  // which would otherwise force PosService.initialize() to re-run
  // (duplicate Firestore listeners / repeated loading states / overflow flicker).
  ref.keepAlive();

  final service = PosService();
  await service.initialize();

  // If PosService has a dispose()/close() method to cancel streams,
  // uncomment the line below:
  // ref.onDispose(() => service.dispose());

  return service;
});

final firebaseServiceProvider = Provider<FirebaseService>((ref) {
  return FirebaseService();
});

final paymentServiceProvider = Provider<PaymentService>((ref) {
  return PaymentService();
});

final warrantyServiceProvider = FutureProvider<WarrantyService>((ref) async {
  ref.keepAlive();

  final service = WarrantyService();
  await service.initialize();

  // Uncomment if WarrantyService has a dispose()/close() method:
  // ref.onDispose(() => service.dispose());

  return service;
});

final communicationServiceProvider = Provider<CommunicationService>((ref) {
  return CommunicationService();
});

final bundleServiceProvider = FutureProvider<BundleService>((ref) async {
  ref.keepAlive();

  final service = BundleService();
  await service.initialize();

  // Uncomment if BundleService has a dispose()/close() method:
  // ref.onDispose(() => service.dispose());

  return service;
});