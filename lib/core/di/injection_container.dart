import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/datasources/auth_remote_datasource_impl.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/domain/usecases/reset_password_usecase.dart';
import '../../features/auth/domain/usecases/signup_usecase.dart';
import '../../features/auth/domain/usecases/watch_auth_state_usecase.dart';

final sl = GetIt.instance;

/// Registers Data Sources → Repositories → Use Cases.
Future<void> configureDependencies() async {
  if (!sl.isRegistered<FirebaseAuth>()) {
    sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  }
  if (!sl.isRegistered<FirebaseFirestore>()) {
    sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  }

  if (!sl.isRegistered<AuthRemoteDataSource>()) {
    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        auth: sl<FirebaseAuth>(),
        firestore: sl<FirebaseFirestore>(),
      ),
    );
  }

  if (!sl.isRegistered<AuthRepository>()) {
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(sl<AuthRemoteDataSource>()),
    );
  }

  if (!sl.isRegistered<LoginUseCase>()) {
    sl.registerLazySingleton(() => LoginUseCase(sl()));
  }
  if (!sl.isRegistered<SignupUseCase>()) {
    sl.registerLazySingleton(() => SignupUseCase(sl()));
  }
  if (!sl.isRegistered<LogoutUseCase>()) {
    sl.registerLazySingleton(() => LogoutUseCase(sl()));
  }
  if (!sl.isRegistered<ResetPasswordUseCase>()) {
    sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));
  }
  if (!sl.isRegistered<WatchAuthStateUseCase>()) {
    sl.registerLazySingleton(() => WatchAuthStateUseCase(sl()));
  }
}
