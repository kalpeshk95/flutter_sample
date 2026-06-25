import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sample/core/theme/text_style_extensions.dart';
import 'package:flutter_sample/ui/screens/profile/widgets/profile_form.dart';
import 'package:flutter_sample/ui/screens/profile/widgets/profile_header.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/widgets/custom_app_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dobController = TextEditingController();
  final _picker = ImagePicker();
  File? _imageFile;
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('user_name') ?? '';
      _emailController.text = prefs.getString('user_email') ?? '';
      _phoneController.text = prefs.getString('user_phone') ?? '';
      _dobController.text = prefs.getString('user_dob') ?? '';
      _imagePath = prefs.getString('user_image_path');
    });
  }

  Future<void> _saveUserData() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      await Future.wait([
        prefs.setString('user_name', _nameController.text),
        prefs.setString('user_email', _emailController.text),
        prefs.setString('user_phone', _phoneController.text),
        prefs.setString('user_dob', _dobController.text),
        if (_imageFile != null) prefs.setString('user_image_path', _imageFile!.path),
      ]);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully!'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        );
      }
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null && mounted) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && mounted) {
      _dobController.text =
          '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
            title: 'My Profile',
            backgroundColor: Colors.transparent,
            centerTitle: false,
            showBackButton: false,
            titleSpacing: 12,
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check, color: colorScheme.onPrimaryContainer),
                ),
                onPressed: _saveUserData,
              ),
            ]),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                colorScheme.primary.withAlpha(26),
                colorScheme.surface,
              ],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Profile Header
                  ProfileHeader(
                    name: _nameController.text,
                    email: _emailController.text,
                    imageFile: _imageFile,
                    imagePath: _imagePath,
                    onPickImage: _pickImage,
                  ),
                  const SizedBox(height: 24),

                  // Profile Form
                  ProfileForm(
                    formKey: _formKey,
                    nameController: _nameController,
                    emailController: _emailController,
                    phoneController: _phoneController,
                    dobController: _dobController,
                    onSelectDate: _selectDate,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
