import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

String formatFirestoreError(Object error, {String? context}) {
  final prefix = context != null && context.isNotEmpty ? '$context - ' : '';
  if (error is FirebaseException) {
    return '$prefix[${error.runtimeType}] ${error.code}: ${error.message ?? error.toString()}';
  }

  return '$prefix[${error.runtimeType}] ${error.toString()}';
}

void logFirestoreError(Object error, StackTrace? stackTrace, {String? context}) {
  final message = formatFirestoreError(error, context: context);
  debugPrint('Firestore error: $message');
  if (stackTrace != null) {
    debugPrint(stackTrace.toString());
  }
}

Future<T> runFirestoreOperation<T>(Future<T> Function() operation, {String? context}) async {
  try {
    return await operation();
  } on FirebaseException catch (e, stackTrace) {
    logFirestoreError(e, stackTrace, context: context);
    rethrow;
  } catch (e, stackTrace) {
    logFirestoreError(e, stackTrace, context: context);
    rethrow;
  }
}
