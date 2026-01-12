import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/vpn_provider.dart';
import '../widgets/cyber_button.dart';
import '../widgets/speed_graph.dart';
import 'server_selection_sheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Deep black background
      body: Stack(
        children: [
          // Background Elements (Glows)
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.purpleAccent.withOpacity(0.2),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.purpleAccent,
                    blurRadius: 100,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.cyanAccent.withOpacity(0.15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.cyanAccent,
                    blurRadius: 80,
                    spreadRadius: 30,
                  ),
                ],
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.menu, color: Colors.white),
                      Text(
                        "CYBER VPN",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          shadows: [
                            Shadow(color: Colors.cyanAccent, blurRadius: 10),
                          ],
                        ),
                      ),
                      const Icon(Icons.settings, color: Colors.white),
                    ],
                  ),
                ),

                const Spacer(),

                // Connect Button
                const CyberButton(),

                const SizedBox(height: 30),

                // Status Text
                Consumer<VpnProvider>(
                  builder: (context, provider, child) {
                     String statusText = "Ready to Connect";
                     if (provider.status == VpnStatus.connecting) statusText = "Establishing Secure Link...";
                     if (provider.status == VpnStatus.connected) statusText = "Secured & Encrypted";

                     return Text(
                       statusText.toUpperCase(),
                       style: TextStyle(
                         color: Colors.grey[400],
                         letterSpacing: 1.2,
                         fontSize: 12,
                       ),
                     );
                  },
                ),

                const Spacer(),
                
                // Speed Graph
                const Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: SpeedGraph(),
                ),

                // Server Selection Widget
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) => const ServerSelectionSheet(),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                    ),
                    child: Consumer<VpnProvider>(
                      builder: (context, provider, child) {
                        return Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.1),
                              ),
                              child: Text(
                                provider.selectedServer.flagEmoji,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Current Server",
                                  style: TextStyle(color: Colors.grey[500], fontSize: 10),
                                ),
                                Text(
                                  provider.selectedServer.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            const Icon(Icons.keyboard_arrow_up, color: Colors.white),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
