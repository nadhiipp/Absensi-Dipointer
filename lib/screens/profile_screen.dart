import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../config/theme.dart';
import '../config/routes.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_button.dart';
import '../widgets/bottom_nav.dart';
import '../services/camera_service.dart';
import 'home_screen.dart';
import 'history_screen.dart';
import 'leave_request_screen.dart';
import 'report_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen();
  
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentIndex = 4;
  bool _isEditing = false;
  
  final List<Widget> _screens = const [
    HomeScreen(),
    HistoryScreen(),
    LeaveRequestScreen(),
    ReportScreen(),
    ProfileScreen(),
  ];
  
  // User data
  String _name = '';
  String _email = '';
  String _nip = '';
  String _department = '';
  String _position = '';
  File? _profilePhoto;
  
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }
  
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString(AppConstants.keyUserName) ?? '';
      _email = prefs.getString(AppConstants.keyUserEmail) ?? '';
      _nip = prefs.getString(AppConstants.keyUserNip) ?? '';
      _department = prefs.getString(AppConstants.keyUserDepartment) ?? '';
      _position = prefs.getString(AppConstants.keyUserPosition) ?? '';
    });
  }
  
  Future<void> _logout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Logout'),
        content: const Text('Apakah Anda yakin ingin keluar?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorColor,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
    
    if (confirm == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.login,
          (route) => false,
        );
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    if (_currentIndex != 4) {
      return _screens[_currentIndex];
    }
    
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: _isEditing ? _buildEditForm() : _buildProfile(),
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _isEditing = false;
          });
        },
      ),
    );
  }
  
  Widget _buildProfile() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Header with Profile Photo
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        child: _profilePhoto != null
                            ? ClipOval(
                                child: Image.file(
                                  _profilePhoto!,
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Icon(
                                Icons.person,
                                size: 60,
                                color: AppTheme.primaryGreen,
                              ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: const Icon(
                              Icons.camera_alt,
                              size: 20,
                              color: AppTheme.primaryGreen,
                            ),
                            onPressed: () async {
                              final cameraService = CameraService();
                              final photo = await cameraService.takePicture();
                              if (photo != null) {
                                setState(() {
                                  _profilePhoto = photo;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _position,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8),
                  
                  // Personal Information
                  const Text(
                    'Informasi Pribadi',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  CustomCard(
                    child: Column(
                      children: [
                        _buildInfoRow(Icons.badge, 'NIP/NIK', _nip),
                        const Divider(height: 24),
                        _buildInfoRow(Icons.email, 'Email', _email),
                        const Divider(height: 24),
                        _buildInfoRow(Icons.business, 'Departemen', _department),
                        const Divider(height: 24),
                        _buildInfoRow(Icons.work, 'Jabatan', _position),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Action Buttons
                  CustomCard(
                    child: Column(
                      children: [
                        _buildMenuTile(
                          icon: Icons.edit,
                          title: 'Edit Profile',
                          onTap: () {
                            setState(() {
                              _isEditing = true;
                            });
                          },
                        ),
                        const Divider(height: 1),
                        _buildMenuTile(
                          icon: Icons.lock,
                          title: 'Ubah Password',
                          onTap: () {
                            Helpers.showSnackBar(
                              context,
                              'Fitur ubah password akan segera hadir',
                            );
                          },
                        ),
                        const Divider(height: 1),
                        _buildMenuTile(
                          icon: Icons.notifications,
                          title: 'Notifikasi',
                          onTap: () {
                            Helpers.showSnackBar(
                              context,
                              'Fitur notifikasi akan segera hadir',
                            );
                          },
                        ),
                        const Divider(height: 1),
                        _buildMenuTile(
                          icon: Icons.help,
                          title: 'Bantuan',
                          onTap: () {
                            Helpers.showSnackBar(
                              context,
                              'Fitur bantuan akan segera hadir',
                            );
                          },
                        ),
                        const Divider(height: 1),
                        _buildMenuTile(
                          icon: Icons.info,
                          title: 'Tentang Aplikasi',
                          onTap: () {
                            showAboutDialog(
                              context: context,
                              applicationName: AppConstants.appName,
                              applicationVersion: AppConstants.appVersion,
                              applicationIcon: const Icon(
                                Icons.fingerprint,
                                size: 48,
                                color: AppTheme.primaryGreen,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  CustomButton(
                    text: 'Logout',
                    onPressed: _logout,
                    icon: Icons.logout,
                    color: AppTheme.errorColor,
                    height: 54,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  Center(
                    child: Text(
                      'Version ${AppConstants.appVersion}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.primaryGreen, size: 24),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildMenuTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        child: Row(
          children: [
            Icon(icon, color: AppTheme.primaryGreen, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppTheme.textPrimary,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppTheme.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildEditForm() {
    return ProfileEditForm(
      name: _name,
      email: _email,
      nip: _nip,
      department: _department,
      position: _position,
      onCancel: () {
        setState(() {
          _isEditing = false;
        });
      },
      onSave: (name, email, nip, department, position) async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(AppConstants.keyUserName, name);
        await prefs.setString(AppConstants.keyUserEmail, email);
        await prefs.setString(AppConstants.keyUserNip, nip);
        await prefs.setString(AppConstants.keyUserDepartment, department);
        await prefs.setString(AppConstants.keyUserPosition, position);
        
        setState(() {
          _name = name;
          _email = email;
          _nip = nip;
          _department = department;
          _position = position;
          _isEditing = false;
        });
        
        Helpers.showSnackBar(context, 'Profile berhasil diperbarui');
      },
    );
  }
}

class ProfileEditForm extends StatefulWidget {
  final String name;
  final String email;
  final String nip;
  final String department;
  final String position;
  final VoidCallback onCancel;
  final Function(String, String, String, String, String) onSave;
  
  const ProfileEditForm({
    required this.name,
    required this.email,
    required this.nip,
    required this.department,
    required this.position,
    required this.onCancel,
    required this.onSave,
  });
  
  @override
  State<ProfileEditForm> createState() => _ProfileEditFormState();
}

class _ProfileEditFormState extends State<ProfileEditForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _nipController;
  late TextEditingController _departmentController;
  late TextEditingController _positionController;
  bool _isLoading = false;
  
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _emailController = TextEditingController(text: widget.email);
    _nipController = TextEditingController(text: widget.nip);
    _departmentController = TextEditingController(text: widget.department);
    _positionController = TextEditingController(text: widget.position);
  }
  
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _nipController.dispose();
    _departmentController.dispose();
    _positionController.dispose();
    super.dispose();
  }
  
  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    setState(() {
      _isLoading = true;
    });
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() {
      _isLoading = false;
    });
    
    widget.onSave(
      _nameController.text,
      _emailController.text,
      _nipController.text,
      _departmentController.text,
      _positionController.text,
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: widget.onCancel,
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Lengkap',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 16),
                
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email tidak boleh kosong';
                    }
                    if (!value.contains('@')) {
                      return 'Email tidak valid';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 16),
                
                TextFormField(
                  controller: _nipController,
                  decoration: const InputDecoration(
                    labelText: 'NIP/NIK',
                    prefixIcon: Icon(Icons.badge),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'NIP/NIK tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 16),
                
                TextFormField(
                  controller: _departmentController,
                  decoration: const InputDecoration(
                    labelText: 'Departemen',
                    prefixIcon: Icon(Icons.business),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Departemen tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 16),
                
                TextFormField(
                  controller: _positionController,
                  decoration: const InputDecoration(
                    labelText: 'Jabatan',
                    prefixIcon: Icon(Icons.work),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Jabatan tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 32),
                
                CustomButton(
                  text: 'Simpan',
                  onPressed: _save,
                  isLoading: _isLoading,
                  icon: Icons.save,
                  height: 54,
                ),
                
                const SizedBox(height: 12),
                
                CustomButton(
                  text: 'Batal',
                  onPressed: widget.onCancel,
                  isOutlined: true,
                  height: 54,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
