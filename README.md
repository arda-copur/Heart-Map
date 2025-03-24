# heartmap

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

CORE/FEATURE KLASÖRLEME
1# Core ana hatlar ve temel işler(dio manager, iDioManager, ErrorManager vb. gibi temel base servisler,apperrors, apptheme, app routes,utils,widgets,networkmanager)
2# Feature proje bazlı geliştirlemeler:
Fakat içerisi modül modül yapılandırır.
Örnek olarak bir Home ekranı varsa.
2.1# Home klasörü açılır > İçerisine data-domain-presentation klasörleri açılır.
2.1.0# Data => models-datasources-repositories klasörleri açılır
models : Home ekranı için kullanılacak model classları
datasources: servislere/apiye istek atacak kaynaklar
repositories: pattern yönetimi
2.1.1# Domain => entities-usecases klasörleri açılır
entities: temiz mimari için
usecases: business logic
2.1.2# Presentation => ui  yönetim işleri. pages-widgets-ve state yönetimi için bir viewmodel. burada bazen bloc bazen provider ile viewmodel kullanıcaz
pages: home ekranı
widgets: home ekranına özel widgetlar
bloc: home ekranı stateini yönetecek bloc yapısı
