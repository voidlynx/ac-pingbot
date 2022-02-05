mkdir -p build
dart format bot.dart
dart compile exe bot.dart -o build/bot
chmod +x build/bot
