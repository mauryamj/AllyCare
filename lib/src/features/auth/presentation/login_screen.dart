import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/auth_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final TextEditingController controllerName = TextEditingController();

  String? errorMessage = '';
  bool isRegisterMode = false;
  bool isLoading = false;

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPassword.dispose();
    controllerName.dispose();
    super.dispose();
  }

  Future<void> tryLogin() async {
    if (controllerEmail.text.isEmpty || controllerPassword.text.isEmpty) {
      setState(() => errorMessage = "Email & password cannot be empty.");
      return;
    }

    setState(() {
      errorMessage = '';
      isLoading = true;
    });

    final svc = ref.read(authServiceProvider);
    final email = controllerEmail.text.trim();
    final password = controllerPassword.text.trim();

    try {
      await svc.signIn(email: email, password: password);

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/assessments');
    } on FirebaseAuthException catch (e) {
      setState(() {
        switch (e.code) {
          case 'user-not-found':
          case 'invalid-credential':
            isRegisterMode = true;
            errorMessage = 'No account found — create one below.';
            break;
          case 'wrong-password':
            errorMessage = 'Wrong password, try again.';
            break;
          case 'invalid-email':
            errorMessage = 'Please enter a valid email address.';
            break;
          default:
            errorMessage = e.message ?? 'Login failed';
        }
      });
    } catch (e) {
      setState(() => errorMessage = 'Unexpected error: ${e.toString()}');
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> register() async {
    if (controllerEmail.text.isEmpty ||
        controllerPassword.text.isEmpty ||
        controllerName.text.isEmpty) {
      setState(() => errorMessage = "All fields are required.");
      return;
    }

    setState(() {
      errorMessage = '';
      isLoading = true;
    });

    final svc = ref.read(authServiceProvider);
    final email = controllerEmail.text.trim();
    final password = controllerPassword.text.trim();
    final name = controllerName.text.trim();

    try {
      await svc.createAccount(
        email: email,
        password: password,
        displayName: name.isEmpty ? null : name,
      );

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/assessments');
    } on FirebaseAuthException catch (e) {
      setState(() => errorMessage = e.message ?? 'Registration failed');
    } catch (e) {
      setState(() => errorMessage = 'Unexpected error: ${e.toString()}');
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Future<void> resetPassword() async {
    if (controllerEmail.text.isEmpty) {
      setState(() => errorMessage = "Enter your email first.");
      return;
    }

    setState(() {
      errorMessage = '';
      isLoading = true;
    });

    final svc = ref.read(authServiceProvider);
    final email = controllerEmail.text.trim();

    try {
      await svc.resetPassword(email: email);
      setState(() => errorMessage = 'Password reset email sent.');
    } on FirebaseAuthException catch (e) {
      setState(() => errorMessage = e.message ?? 'Error sending reset email');
    } catch (e) {
      setState(() => errorMessage = 'Unexpected error: ${e.toString()}');
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isProcessing = isLoading;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/app_icon.png", width: 130),
                const SizedBox(height: 12),
                Text(
                  isRegisterMode
                      ? "Create your new account"
                      : "Login to your account",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: controllerEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                    prefixIcon: const Icon(Icons.email),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.blue.shade800,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: controllerPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: isRegisterMode
                        ? "Create your Password"
                        : "Enter your Password",
                    prefixIcon: const Icon(Icons.lock),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.blue.shade800,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: resetPassword,
                    child: const Text("Forgot Password?"),
                  ),
                ),
                if (isRegisterMode) ...[
                  const SizedBox(height: 8),
                  TextField(
                    controller: controllerName,
                    decoration: InputDecoration(
                      hintText: "Enter your name",
                      prefixIcon: const Icon(Icons.person),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.blue.shade800,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                if (errorMessage != null && errorMessage!.isNotEmpty)
                  Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: isRegisterMode ? register : tryLogin,
                  style: FilledButton.styleFrom(
                    backgroundColor: isRegisterMode
                        ? Colors.green[700]
                        : Colors.blue[800],
                    fixedSize: const Size(200, 50),
                  ),
                  child: isProcessing
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              isRegisterMode ? "Create Account" : "Continue",
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset("assets/images/bottom_style.png", width: double.infinity),
          const Positioned(
            bottom: 25,
            child: Row(
              children: [
                Icon(Icons.headset_mic),
                Text(
                  "Support",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
