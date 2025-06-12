import 'package:flutter/material.dart';
import 'package:recycle_game/screens/main_menu_screen.dart';
import 'package:recycle_game/services/auth_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:recycle_game/services/settings_service.dart';
import 'package:recycle_game/services/audio_service.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  late AppLocalizations localizations;

  bool _isLogin = true;
  bool _isLoading = false;
  bool _rememberMe = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String? _errorMessage;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    localizations = AppLocalizations.of(context)!;
  }

  @override
  void initState() {
    super.initState();
    _loadRememberedCredentials();
  }

  Future<void> _loadRememberedCredentials() async {
    final remembered = await _authService.getRememberMe();
    if (remembered) {
      final credentials = await _authService.getRememberedCredentials();
      setState(() {
        _emailController.text = credentials['email'] ?? '';
        _passwordController.text = credentials['password'] ?? '';
        _rememberMe = true;
      });
    }
  }

  Future<void> _submitAuthForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      if (_isLogin) {
        await _authService.signInWithEmail(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
        await _authService.setRememberMe(
          _rememberMe,
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      } else {
        await _authService.registerWithEmail(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
        await _authService.setRememberMe(
          _rememberMe,
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      }
      
      if (mounted && _authService.user.isBroadcast) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainMenuScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        String errorMessage;
        if (e.toString().contains('email-already-in-use')) {
          errorMessage = localizations.errorEmailAlreadyInUse;
        } else if (e.toString().contains('invalid-credential')) {
          errorMessage = localizations.errorInvalidCredentials;
        } else if (e.toString().contains('weak-password')) {
          errorMessage = localizations.errorWeakPassword;
        } else if (e.toString().contains('user-not-found')) {
          errorMessage = localizations.errorUserNotFound;
        } else if (e.toString().contains('too-many-requests')) {
          errorMessage = localizations.errorTooManyRequests;
        } else if (e.toString().contains('network-request-failed')) {
          errorMessage = localizations.errorNetworkRequestFailed;
        } else {
          errorMessage = e.toString().replaceAll('Exception: ', '');
        }
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _loginAsGuest() async {
     setState(() => _isLoading = true);
     await _authService.signInAsGuest();
     if(mounted){
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainMenuScreen()),
        );
     }
     setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                builder: (context) => _SettingsModal(),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/default/recycle_logo.png', height: 120),
                const SizedBox(height: 20),
                Text(
                  _isLogin ? localizations.login : localizations.register,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: localizations.email),
                  validator: (value) => value!.isEmpty || !value.contains('@') 
                    ? localizations.errorInvalidEmail 
                    : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: localizations.password,
                    suffixIcon: IconButton(
                      icon: Image.asset(
                        _obscurePassword
                          ? 'assets/images/default/show.png'
                          : 'assets/images/default/hide.png',
                        height: 24,
                        width: 24,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  obscureText: _obscurePassword,
                  validator: (value) => value!.length < 6 
                    ? localizations.errorPasswordTooShort 
                    : null,
                ),
                if (!_isLogin) ...[
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: localizations.confirmPassword,
                      suffixIcon: IconButton(
                        icon: Image.asset(
                          _obscureConfirmPassword
                            ? 'assets/images/default/show.png'
                            : 'assets/images/default/hide.png',
                          height: 24,
                          width: 24,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                    ),
                    obscureText: _obscureConfirmPassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) 
                        return localizations.errorConfirmPassword;
                      if (value != _passwordController.text) 
                        return localizations.errorPasswordsDoNotMatch;
                      return null;
                    },
                  ),
                ],
                const SizedBox(height: 20),
                if (_isLogin)
                  CheckboxListTile(
                    title: Text(localizations.rememberMe),
                    value: _rememberMe,
                    onChanged: (value) => setState(() => _rememberMe = value!),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                  ),
                const SizedBox(height: 20),
                if (_isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: _submitAuthForm,
                    style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
                    child: Text(_isLogin ? localizations.login : localizations.register),
                  ),
                TextButton(
                  onPressed: () => setState(() => _isLogin = !_isLogin),
                  child: Text(_isLogin ? localizations.dontHaveAccount : localizations.alreadyHaveAccount),
                ),
                const Divider(height: 30),
                TextButton.icon(
                    icon: const Icon(Icons.person_outline),
                    label: Text(localizations.guestLogin),
                    onPressed: _loginAsGuest,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SettingsModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final settings = Provider.of<SettingsService>(context);
    double musicVolume = settings.musicVolume;
    double sfxVolume = settings.sfxVolume;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(localizations?.settings ?? '', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(localizations?.music ?? '', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Consumer<SettingsService>(
            builder: (context, settings, _) => Slider(
              value: settings.musicVolume,
              min: 0.0,
              max: 1.0,
              divisions: 10,
              label: (settings.musicVolume * 100).toInt().toString(),
              onChanged: (value) {
                settings.setMusicVolume(value);
                AudioService.updateSettings(value, settings.sfxVolume);
              },
            ),
          ),
          const SizedBox(height: 16),
          Text(localizations?.soundEffects ?? '', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Consumer<SettingsService>(
            builder: (context, settings, _) => Slider(
              value: settings.sfxVolume,
              min: 0.0,
              max: 1.0,
              divisions: 10,
              label: (settings.sfxVolume * 100).toInt().toString(),
              onChanged: (value) {
                settings.setSfxVolume(value);
                AudioService.updateSettings(settings.musicVolume, value);
              },
            ),
          ),
          const SizedBox(height: 24),
          Text(localizations?.language ?? '', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: RadioListTile<String>(
                  title: const Text('English'),
                  value: 'en',
                  groupValue: settings.locale.languageCode,
                  onChanged: (value) {
                    if (value != null) {
                      settings.setLocale(Locale(value));
                    }
                  },
                ),
              ),
              Expanded(
                child: RadioListTile<String>(
                  title: const Text('Türkçe'),
                  value: 'tr',
                  groupValue: settings.locale.languageCode,
                  onChanged: (value) {
                    if (value != null) {
                      settings.setLocale(Locale(value));
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}