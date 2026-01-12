import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/server_model.dart';
import 'package:fl_chart/fl_chart.dart';

enum VpnStatus { disconnected, connecting, connected }

class VpnProvider with ChangeNotifier {
  VpnStatus _status = VpnStatus.disconnected;
  VpnServer _selectedServer = dummyServers[0];
  Timer? _timer;
  Duration _connectionDuration = Duration.zero;
  
  // Speed Graph Data
  List<FlSpot> _uploadSpots = [];
  List<FlSpot> _downloadSpots = [];
  double _xValue = 0;

  VpnStatus get status => _status;
  VpnServer get selectedServer => _selectedServer;
  Duration get connectionDuration => _connectionDuration;
  List<FlSpot> get uploadSpots => _uploadSpots;
  List<FlSpot> get downloadSpots => _downloadSpots;

  String get durationText {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(_connectionDuration.inMinutes.remainder(60));
    final seconds = twoDigits(_connectionDuration.inSeconds.remainder(60));
    return "${twoDigits(_connectionDuration.inHours)}:$minutes:$seconds";
  }

  void selectServer(VpnServer server) {
    _selectedServer = server;
    notifyListeners();
  }

  void toggleConnection() {
    if (_status == VpnStatus.disconnected) {
      _connect();
    } else if (_status == VpnStatus.connected) {
      _disconnect();
    }
  }

  void _connect() async {
    _status = VpnStatus.connecting;
    notifyListeners();

    // Mock connection delay
    await Future.delayed(const Duration(seconds: 2));

    _status = VpnStatus.connected;
    _startTimer();
    notifyListeners();
  }

  void _disconnect() {
    _status = VpnStatus.disconnected;
    _stopTimer();
    _connectionDuration = Duration.zero;
    _uploadSpots.clear();
    _downloadSpots.clear();
    _xValue = 0;
    notifyListeners();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _connectionDuration += const Duration(seconds: 1);
      _updateSpeedGraph();
      notifyListeners();
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _updateSpeedGraph() {
    // Generate random speed values
    final random = Random();
    double upload = 5 + random.nextDouble() * 10; // 5-15 Mbps
    double download = 20 + random.nextDouble() * 50; // 20-70 Mbps
    
    _xValue += 1;
    _uploadSpots.add(FlSpot(_xValue, upload));
    _downloadSpots.add(FlSpot(_xValue, download));

    // Keep only last 20 points
    if (_uploadSpots.length > 20) {
      _uploadSpots.removeAt(0);
      _downloadSpots.removeAt(0);
    }
  }
}
