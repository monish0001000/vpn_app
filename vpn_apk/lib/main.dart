import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'providers/vpn_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const CyberpunkVpnApp());
}

class CyberpunkVpnApp extends StatelessWidget {
  const CyberpunkVpnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VpnProvider()),
      ],
      child: MaterialApp(
        title: 'Cyberpunk VPN',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.cyanAccent,
          scaffoldBackgroundColor: Colors.black,
          textTheme: GoogleFonts.outfitTextTheme(
            Theme.of(context).textTheme.apply(bodyColor: Colors.white),
          ),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
