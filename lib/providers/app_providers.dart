import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/firebase_service.dart';
import '../services/payment_service.dart';
import '../services/pos_service.dart';
import '../services/warranty_service.dart';
import '../services/bundle_service.dart';
import '../services/communication_service.dart';

export 'notification_provider.dart';
export 'auth_provider.dart';
export 'staff_provider.dart';
export 'attendance_provider.dart';
export 'leave_provider.dart';
export 'salary_provider.dart';
export 'salary_request_provider.dart';

final posServiceProvider = FutureProvider<PosService>((ref) async {
  final service = PosService();
  await service.initialize();
  return service;
});

final firebaseServiceProvider = Provider<FirebaseService>((ref) {
  return FirebaseService();
});

final paymentServiceProvider = Provider<PaymentService>((ref) {
  return PaymentService();
});

final warrantyServiceProvider = FutureProvider<WarrantyService>((ref) async {
  final service = WarrantyService();
  await service.initialize();
  return service;
});

final communicationServiceProvider = Provider<CommunicationService>((ref) {
  return CommunicationService();
});

final bundleServiceProvider = FutureProvider<BundleService>((ref) async {
  final service = BundleService();
  await service.initialize();
  return service;
});

