class VpnServer {
  final String name;
  final String countryCode;
  final String flagEmoji;
  final String ping;

  VpnServer({
    required this.name,
    required this.countryCode,
    required this.flagEmoji,
    required this.ping,
  });
}

final List<VpnServer> dummyServers = [
  VpnServer(name: 'United States', countryCode: 'US', flagEmoji: '🇺🇸', ping: '12ms'),
  VpnServer(name: 'United Kingdom', countryCode: 'UK', flagEmoji: '🇬🇧', ping: '45ms'),
  VpnServer(name: 'Germany', countryCode: 'DE', flagEmoji: '🇩🇪', ping: '38ms'),
  VpnServer(name: 'Japan', countryCode: 'JP', flagEmoji: '🇯🇵', ping: '110ms'),
  VpnServer(name: 'Singapore', countryCode: 'SG', flagEmoji: '🇸🇬', ping: '85ms'),
];
