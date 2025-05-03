import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/authentication/authentication_bloc.dart';
import 'repositories/authentication_repository.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final AuthenticationRepository authenticationRepository = AuthenticationRepository();

  runApp(
    RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(authenticationRepository: authenticationRepository),
        child: const ShopkeeperApp(),
      ),
    ),
  );
}
