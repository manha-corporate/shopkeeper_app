import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/authentication/authentication_bloc.dart';
import '../repositories/authentication_repository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  void _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final authRepo = RepositoryProvider.of<AuthenticationRepository>(context);

    try {
      await authRepo.signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      final user = await authRepo.getUser();
      context.read<AuthenticationBloc>().add(AuthenticationLoggedIn(user));
    } catch (e) {
      setState(() {
        _errorMessage = 'Login failed. Please check your credentials.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _navigateToSignUp() {
    // TODO: Implement navigation to sign up screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopkeeper Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _login,
                    child: const Text('Login'),
                  ),
            TextButton(
              onPressed: _navigateToSignUp,
              child: const Text('Create an account'),
            ),
          ],
        ),
      ),
    );
  }
}
