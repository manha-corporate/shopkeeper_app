import 'package:bloc/bloc.dart';
import '../../repositories/authentication_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;

  AuthenticationBloc({required this.authenticationRepository}) : super(AuthenticationInitial()) {
    on<AuthenticationStarted>((event, emit) async {
      final isSignedIn = await authenticationRepository.isSignedIn();
      if (isSignedIn) {
        final user = await authenticationRepository.getUser();
        emit(AuthenticationAuthenticated(user));
      } else {
        emit(AuthenticationUnauthenticated());
      }
    });

    on<AuthenticationLoggedIn>((event, emit) {
      emit(AuthenticationAuthenticated(event.user));
    });

    on<AuthenticationLoggedOut>((event, emit) async {
      await authenticationRepository.signOut();
      emit(AuthenticationUnauthenticated());
    });
  }
}
