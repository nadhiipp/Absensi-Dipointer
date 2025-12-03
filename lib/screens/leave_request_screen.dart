import 'package:flutter/material.dart';
import 'dart:io';
import '../config/theme.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_button.dart';
import '../widgets/bottom_nav.dart';
import '../services/camera_service.dart';
import 'home_screen.dart';
import 'history_screen.dart';
import 'report_screen.dart';
import 'profile_screen.dart';

class LeaveRequestScreen extends StatefulWidget {
  const LeaveRequestScreen();
  
  @override
  State<LeaveRequestScreen> createState() => _LeaveRequestScreenState();
}

class _LeaveRequestScreenState extends State<LeaveRequestScreen> {
  int _currentIndex = 2;
  bool _showForm = false;
  
  final List<Widget> _screens = const [
    HomeScreen(),
    HistoryScreen(),
    LeaveRequestScreen(),
    ReportScreen(),
    ProfileScreen(),
  ];
  
  // Dummy leave request data
  final List<Map<String, dynamic>> _leaveRequests = [
    {
      'id': '1',
      'type': 'Sakit',
      'startDate': DateTime.now().subtract(const Duration(days: 3)),
      'endDate': DateTime.now().subtract(const Duration(days: 3)),
      'reason': 'Demam tinggi',
      'status': 'pending',
      'createdAt': DateTime.now().subtract(const Duration(days: 3)),
    },
    {
      'id': '2',
      'type': 'Cuti Tahunan',
      'startDate': DateTime.now().add(const Duration(days: 7)),
      'endDate': DateTime.now().add(const Duration(days: 9)),
      'reason': 'Liburan keluarga',
      'status': 'approved',
      'createdAt': DateTime.now().subtract(const Duration(days: 5)),
    },
    {
      'id': '3',
      'type': 'Izin Pribadi',
      'startDate': DateTime.now().subtract(const Duration(days: 10)),
      'endDate': DateTime.now().subtract(const Duration(days: 10)),
      'reason': 'Urusan keluarga',
      'status': 'rejected',
      'createdAt': DateTime.now().subtract(const Duration(days: 12)),
    },
  ];
  
  @override
  Widget build(BuildContext context) {
    if (_currentIndex != 2) {
      return _screens[_currentIndex];
    }
    
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Request Izin/Cuti'),
        backgroundColor: AppTheme.primaryGreen,
        automaticallyImplyLeading: false,
      ),
      body: _showForm ? _buildForm() : _buildList(),
      floatingActionButton: !_showForm
          ? FloatingActionButton.extended(
              onPressed: () {
                setState(() {
                  _showForm = true;
                });
              },
              backgroundColor: AppTheme.primaryGreen,
              icon: const Icon(Icons.add),
              label: const Text('Ajukan Izin'),
            )
          : null,
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _showForm = false;
          });
        },
      ),
    );
  }
  
  Widget _buildList() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Summary Card
        CustomCard(
          gradient: AppTheme.primaryGradient,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSummaryItem('Pending', '1', Icons.hourglass_empty),
              _buildSummaryItem('Approved', '1', Icons.check_circle),
              _buildSummaryItem('Rejected', '1', Icons.cancel),
            ],
          ),
        ),
        
        const SizedBox(height: 16),
        
        const Text(
          'Riwayat Pengajuan',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        
        const SizedBox(height: 12),
        
        // Leave Requests List
        ..._leaveRequests.map((request) {
          return _buildLeaveRequestCard(request);
        }).toList(),
      ],
    );
  }
  
  Widget _buildSummaryItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 32),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
  
  Widget _buildLeaveRequestCard(Map<String, dynamic> request) {
    final statusColor = Helpers.getStatusColor(request['status']);
    final startDate = request['startDate'] as DateTime;
    final endDate = request['endDate'] as DateTime;
    final duration = endDate.difference(startDate).inDays + 1;
    
    return CustomCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                request['type'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  request['status'].toString().toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 16, color: AppTheme.textSecondary),
              const SizedBox(width: 4),
              Text(
                '${Helpers.formatDate(startDate)} - ${Helpers.formatDate(endDate)}',
                style: const TextStyle(
                  fontSize: 13,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.access_time, size: 16, color: AppTheme.textSecondary),
              const SizedBox(width: 4),
              Text(
                '$duration hari',
                style: const TextStyle(
                  fontSize: 13,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            request['reason'],
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Diajukan: ${Helpers.formatDate(request['createdAt'])}',
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildForm() {
    return LeaveRequestForm(
      onCancel: () {
        setState(() {
          _showForm = false;
        });
      },
      onSubmit: () {
        Helpers.showSnackBar(context, 'Pengajuan izin berhasil dikirim');
        setState(() {
          _showForm = false;
        });
      },
    );
  }
}

class LeaveRequestForm extends StatefulWidget {
  final VoidCallback onCancel;
  final VoidCallback onSubmit;
  
  const LeaveRequestForm({
    required this.onCancel,
    required this.onSubmit,
  });
  
  @override
  State<LeaveRequestForm> createState() => _LeaveRequestFormState();
}

class _LeaveRequestFormState extends State<LeaveRequestForm> {
  final _formKey = GlobalKey<FormState>();
  final CameraService _cameraService = CameraService();
  
  String _selectedLeaveType = AppConstants.leaveTypes[0];
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  final _reasonController = TextEditingController();
  File? _attachmentFile;
  bool _isLoading = false;
  
  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }
  
  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : _endDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          if (_endDate.isBefore(_startDate)) {
            _endDate = _startDate;
          }
        } else {
          _endDate = picked;
        }
      });
    }
  }
  
  Future<void> _pickAttachment() async {
    final file = await _cameraService.pickImageFromGallery();
    if (file != null) {
      setState(() {
        _attachmentFile = file;
      });
    }
  }
  
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    setState(() {
      _isLoading = true;
    });
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    setState(() {
      _isLoading = false;
    });
    
    widget.onSubmit();
  }
  
  @override
  Widget build(BuildContext context) {
    final duration = _endDate.difference(_startDate).inDays + 1;
    
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<String>(
                value: _selectedLeaveType,
                decoration: const InputDecoration(
                  labelText: 'Jenis Izin',
                  prefixIcon: Icon(Icons.category),
                ),
                items: AppConstants.leaveTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedLeaveType = value;
                    });
                  }
                },
              ),
              
              const SizedBox(height: 16),
              
              InkWell(
                onTap: () => _selectDate(context, true),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Tanggal Mulai',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(Helpers.formatDate(_startDate)),
                ),
              ),
              
              const SizedBox(height: 16),
              
              InkWell(
                onTap: () => _selectDate(context, false),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Tanggal Selesai',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(Helpers.formatDate(_endDate)),
                ),
              ),
              
              const SizedBox(height: 8),
              
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: AppTheme.primaryGreen,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Durasi: $duration hari',
                      style: const TextStyle(
                        color: AppTheme.primaryGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _reasonController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Alasan/Keterangan',
                  hintText: 'Jelaskan alasan pengajuan izin Anda',
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alasan tidak boleh kosong';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              OutlinedButton.icon(
                onPressed: _pickAttachment,
                icon: const Icon(Icons.attach_file),
                label: Text(
                  _attachmentFile == null 
                      ? 'Lampirkan File (Opsional)' 
                      : 'File terlampir',
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              
              if (_attachmentFile != null) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle, color: AppTheme.successColor),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'File berhasil dilampirkan',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, size: 20),
                        onPressed: () {
                          setState(() {
                            _attachmentFile = null;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
              
              const SizedBox(height: 24),
              
              CustomButton(
                text: 'Kirim Pengajuan',
                onPressed: _submit,
                isLoading: _isLoading,
                icon: Icons.send,
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
    );
  }
}
