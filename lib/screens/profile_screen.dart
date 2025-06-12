import 'package:flutter/material.dart';
import 'package:recycle_game/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:recycle_game/services/auth_service.dart';
import 'package:recycle_game/services/firestore_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  bool _isLoading = false;
  String _currentDisplayName = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() => _isLoading = true);
    final authService = Provider.of<AuthService>(context, listen: false);
    final firestoreService = Provider.of<FirestoreService>(context, listen: false);
    
    final user = await authService.user.first;
    if (user != null) {
      _currentDisplayName = await firestoreService.getDisplayName(user.uid);
      _nameController.text = _currentDisplayName;
    }
    setState(() => _isLoading = false);
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);
    final authService = Provider.of<AuthService>(context, listen: false);
    await authService.updateDisplayName(_nameController.text);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.profileUpdated)),
      );
    }
    
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.profile),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : authService.isGuest
              ? Center(child: Text(localizations.guestProgressWarning))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: localizations.displayName,
                          ),
                          validator: (value) => value!.isEmpty 
                              ? localizations.nameCannotBeEmpty 
                              : null,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _saveProfile,
                          child: Text(localizations.save),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}