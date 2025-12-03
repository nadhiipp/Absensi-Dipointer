import 'package:flutter/material.dart';
import 'dart:io';
import '../config/theme.dart';
import '../services/location_service.dart';
import '../services/camera_service.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_card.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen();
  
  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final LocationService _locationService = LocationService();
  final CameraService _cameraService = CameraService();
  
  bool _isLoading = false;
  bool _hasClockIn = false;
  String? _clockInTime;
  String? _clockOutTime;
  File? _capturedImage;
  double? _latitude;
  double? _longitude;
  bool _isWithinRadius = false;
  
  @override
  void initState() {
    super.initState();
    _checkCurrentLocation();
  }
  
  Future<void> _checkCurrentLocation() async {
    setState(() {
      _isLoading = true;
    });
    
    final position = await _locationService.getCurrentLocation();
    
    if (position != null) {
      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
        _isWithinRadius = Helpers.isWithinValidRadius(
          position.latitude,
          position.longitude,
        );
      });
    } else {
      if (mounted) {
        Helpers.showSnackBar(
          context,
          'Gagal mendapatkan lokasi. Pastikan GPS aktif.',
          isError: true,
        );
      }
    }
    
    setState(() {
      _isLoading = false;
    });
  }
  
  Future<void> _takeSelfie() async {
    final photo = await _cameraService.takePicture();
    if (photo != null) {
      setState(() {
        _capturedImage = photo;
      });
    }
  }
  
  Future<void> _clockIn() async {
    if (_capturedImage == null) {
      Helpers.showSnackBar(
        context,
        'Silakan ambil foto selfie terlebih dahulu',
        isError: true,
      );
      return;
    }
    
    if (_latitude == null || _longitude == null) {
      Helpers.showSnackBar(
        context,
        'Lokasi tidak terdeteksi',
        isError: true,
      );
      return;
    }
    
    setState(() {
      _isLoading = true;
    });
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    // Save photo
    final savedPath = await _cameraService.savePhoto(_capturedImage!, 'clock_in');
    
    final now = DateTime.now();
    setState(() {
      _hasClockIn = true;
      _clockInTime = Helpers.formatTime(now);
      _isLoading = false;
    });
    
    if (mounted) {
      Helpers.showSnackBar(
        context,
        'Clock In berhasil! ${_isWithinRadius ? "Dalam radius kantor" : "Di luar radius kantor"}',
      );
    }
  }
  
  Future<void> _clockOut() async {
    if (_capturedImage == null) {
      Helpers.showSnackBar(
        context,
        'Silakan ambil foto selfie terlebih dahulu',
        isError: true,
      );
      return;
    }
    
    setState(() {
      _isLoading = true;
    });
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    // Save photo
    final savedPath = await _cameraService.savePhoto(_capturedImage!, 'clock_out');
    
    final now = DateTime.now();
    setState(() {
      _clockOutTime = Helpers.formatTime(now);
      _isLoading = false;
    });
    
    if (mounted) {
      Helpers.showSnackBar(
        context,
        'Clock Out berhasil!',
      );
      
      // Go back after successful clock out
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pop(context);
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Absensi'),
        backgroundColor: AppTheme.primaryGreen,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Location Status Card
                  CustomCard(
                    gradient: _isWithinRadius 
                        ? AppTheme.cardGradient 
                        : null,
                    color: _isWithinRadius 
                        ? null 
                        : AppTheme.warningColor.withOpacity(0.1),
                    child: Row(
                      children: [
                        Icon(
                          _isWithinRadius 
                              ? Icons.location_on 
                              : Icons.location_off,
                          color: _isWithinRadius 
                              ? Colors.white 
                              : AppTheme.warningColor,
                          size: 32,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _isWithinRadius 
                                    ? 'Dalam Radius Kantor' 
                                    : 'Di Luar Radius Kantor',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: _isWithinRadius 
                                      ? Colors.white 
                                      : AppTheme.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _latitude != null 
                                    ? 'Lat: ${_latitude!.toStringAsFixed(4)}, Lon: ${_longitude!.toStringAsFixed(4)}'
                                    : 'Lokasi tidak tersedia',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _isWithinRadius 
                                      ? Colors.white70 
                                      : AppTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.refresh,
                            color: _isWithinRadius 
                                ? Colors.white 
                                : AppTheme.primaryGreen,
                          ),
                          onPressed: _checkCurrentLocation,
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Camera Preview
                  CustomCard(
                    child: Column(
                      children: [
                        Container(
                          height: 300,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: _capturedImage != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    _capturedImage!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                )
                              : Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.camera_alt,
                                        size: 64,
                                        color: Colors.grey[400],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Belum ada foto',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                        const SizedBox(height: 16),
                        CustomButton(
                          text: 'Ambil Foto Selfie',
                          onPressed: _takeSelfie,
                          icon: Icons.camera_alt,
                          isOutlined: true,
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Clock In/Out Status
                  if (_hasClockIn) ...[
                    CustomCard(
                      color: AppTheme.successColor.withOpacity(0.1),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: AppTheme.successColor,
                            size: 32,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Clock In',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.successColor,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _clockInTime ?? '-',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  
                  if (_clockOutTime != null) ...[
                    CustomCard(
                      color: AppTheme.infoColor.withOpacity(0.1),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: AppTheme.infoColor,
                            size: 32,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Clock Out',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.infoColor,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _clockOutTime ?? '-',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  
                  // Action Buttons
                  if (!_hasClockIn)
                    CustomButton(
                      text: 'Clock In',
                      onPressed: _clockIn,
                      icon: Icons.login,
                      height: 54,
                    )
                  else if (_clockOutTime == null)
                    CustomButton(
                      text: 'Clock Out',
                      onPressed: _clockOut,
                      icon: Icons.logout,
                      height: 54,
                    )
                  else
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.successColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          'Absensi hari ini sudah lengkap',
                          style: TextStyle(
                            color: AppTheme.successColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}
