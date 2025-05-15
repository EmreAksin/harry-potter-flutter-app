# Harry Potter Karakterleri Flutter Uygulaması

Bu proje, Daynex Yazılım teknik değerlendirme süreci için geliştirilmiş bir Flutter mobil uygulamasıdır. Uygulama, [Harry Potter API](https://hp-api.onrender.com) üzerinden karakter verilerini alarak kullanıcı dostu bir arayüzde listeler ve karakter detaylarını sunar.

## Uygulama Özellikleri

*   **Karakter Listeleme:** Tüm Harry Potter karakterlerinin scroll edilebilir bir listede gösterimi.
*   **Karakter Detayları:** Seçilen karakterin resmi, adı, evi, aktörü gibi detaylı bilgilerinin gösterildiği ayrı bir sayfa.
*   **Arama Fonksiyonu:** Karakter listesinde isim, ev veya aktör bilgisine göre filtreleme yapabilen, anlık çalışan bir arama çubuğu.
*   **Durum Yönetimi:** BLoC pattern kullanılarak UI ile iş mantığının ayrılması ve reaktif güncellemeler.
*   **API Entegrasyonu:** Dio kütüphanesi ile API isteklerinin yönetimi, zaman aşımları ve temel hata yakalama.
*   **Modern Widget Yapısı:** Flutter Hooks kullanılarak daha sade ve yönetilebilir widget'lar (örneğin, arama çubuğundaki debounce mekanizması).
*   **Yeniden Kullanılabilir Bileşenler:** `CharacterListItem` ve `CharacterDetailCard` gibi özel widget'lar oluşturularak kod tekrarının azaltılması ve okunabilirliğin artırılması.

## Kullanılan Teknolojiler

*   **Flutter & Dart**
*   **BLoC / Flutter BLoC:** State management
*   **Dio:** HTTP istemcisi
*   **Flutter Hooks:** Widget state ve lifecycle yönetimi

---