import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/vpn_provider.dart';

class CyberButton extends StatelessWidget {
  const CyberButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<VpnProvider>(
      builder: (context, provider, child) {
        Color mainColor;
        String text;
        
        switch (provider.status) {
          case VpnStatus.disconnected:
            mainColor = Colors.cyanAccent;
            text = "CONNECT";
            break;
          case VpnStatus.connecting:
            mainColor = Colors.yellowAccent;
            text = "CONNECTING...";
            break;
          case VpnStatus.connected:
            mainColor = Colors.greenAccent;
            text = "DISCONNECT";
            break;
        }

        return GestureDetector(
          onTap: provider.toggleConnection,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(
                color: mainColor.withOpacity(0.8),
                width: 4,
              ),
              boxShadow: [
                BoxShadow(
                  color: mainColor.withOpacity(0.4),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
                BoxShadow(
                  color: mainColor.withOpacity(0.2),
                  blurRadius: 40,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  key: ValueKey<String>(text),
                  children: [
                    Icon(
                      Icons.power_settings_new,
                      size: 50,
                      color: mainColor,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      text,
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: mainColor,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                    ),
                    if (provider.status == VpnStatus.connected)
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          provider.durationText,
                          style: TextStyle(
                             color: Colors.white.withOpacity(0.7),
                             fontFamily: 'Courier',
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
