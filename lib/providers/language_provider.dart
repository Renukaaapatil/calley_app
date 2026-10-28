import 'package:flutter/foundation.dart';

class LanguageItem {
  final String name;
  final String nativeGreeting;
  final String code;

  const LanguageItem({
    required this.name,
    required this.nativeGreeting,
    required this.code,
  });
}

class LanguageProvider with ChangeNotifier {
  static const List<LanguageItem> supportedLanguages = [
    LanguageItem(name: 'English', nativeGreeting: 'Hi', code: 'en'),
    LanguageItem(name: 'Hindi', nativeGreeting: 'नमस्ते', code: 'hi'),
    LanguageItem(name: 'Bengali', nativeGreeting: 'হ্যালো', code: 'bn'),
    LanguageItem(name: 'Kannada', nativeGreeting: 'ನಮಸ್ಕಾರ', code: 'kn'),
    LanguageItem(name: 'Punjabi', nativeGreeting: 'ਸਤਿ ਸ਼੍ਰੀ ਅਕਾਲ', code: 'pa'),
    LanguageItem(name: 'Tamil', nativeGreeting: 'வணக்கம்', code: 'ta'),
    LanguageItem(name: 'Telugu', nativeGreeting: 'హలో', code: 'te'),
    LanguageItem(name: 'French', nativeGreeting: 'Bonjour', code: 'fr'),
    LanguageItem(name: 'Spanish', nativeGreeting: 'Hola', code: 'es'),
  ];

  LanguageItem _selectedLanguage = supportedLanguages[0];

  LanguageItem get selectedLanguage => _selectedLanguage;

  void selectLanguage(LanguageItem lang) {
    _selectedLanguage = lang;
    notifyListeners();
  }
}
