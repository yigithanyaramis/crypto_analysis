#!/bin/sh

# Flutter önbelleğini temizle
flutter clean

# Android Gradle önbelleğini temizle
cd .. && cd android && ./gradlew clean && cd ..

echo "Version Number ve Version Name pubspec.yaml'den ayarlayınız"

# Kullanıcıdan girdi al
echo "Hangi çıktıyı almak istiyorsunuz? (apk/aab)"
read outputType

# Gelen girdiye göre build işlemleri
if [ "$outputType" == "aab" ]
then
    flutter build appbundle --release
    open build/app/outputs/bundle/release
elif [ "$outputType" == "apk" ]
then
    flutter build apk --release
    open build/app/outputs/flutter-apk
else
    echo "Geçersiz seçenek. Lütfen 'apk' veya 'aab' olarak bir girdi sağlayın."
fi
