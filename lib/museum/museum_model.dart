class MuseumItem { // Modell für die MuseumsInformationen
  const MuseumItem(this.museumName, this.questTitle, this.imageUrl, this.mapExterior, this.mapInterior1, this.mapInterior2, this.mapInterior3, this.description, this.city, this.address, this.webURL, this.phone, this.mail);

  final String museumName; // Name des Museums
  final String questTitle; // Name der "Quest"/des Spiels
  final String imageUrl; // URL der Bilddatei, die in der ListView und Detailansicht gezeigt wird
  final String mapExterior; // Name der Datei der HauptMap. Untergeordnete Maps werden durch benutzerdefinierte Eigenschaften im Tiled-Editor vermerkt (dynamisch)
  final String mapInterior1; // Name der Datei der 1. InteriorMap. Untergeordnete Maps werden durch benutzerdefinierte Eigenschaften im Tiled-Editor vermerkt (dynamisch)
  final String mapInterior2; // Name der Datei der 2. InteriorMap. Untergeordnete Maps werden durch benutzerdefinierte Eigenschaften im Tiled-Editor vermerkt (dynamisch)
  final String mapInterior3; // Name der Datei der 3. InteriorMap. Untergeordnete Maps werden durch benutzerdefinierte Eigenschaften im Tiled-Editor vermerkt (dynamisch)
  final String description;
  final String city;
  final String address;
  final String webURL;
  final String phone;
  final String mail;

  factory MuseumItem.fromJson(Map<String, dynamic> json) {
    return MuseumItem(
      json['museumName'] as String? ?? 'Unknown Museum',
      json['questTitle'] as String? ?? 'Unknown Quest',
      json['imageUrl'] as String? ?? 'No Image Found',
      json['mapExterior'] as String? ?? 'No Map Found',
      json['mapInterior1'] as String? ?? 'No Map Found',
      json['mapInterior2'] as String? ?? 'No Map Found',
      json['mapInterior3'] as String? ?? 'No Map Found',
      json['description'] as String? ?? 'No Description Found',
      json['city'] as String? ?? 'No City Found',
      json['address'] as String? ?? 'No Address Found',
      json['webURL'] as String? ?? 'No WebURL Found',
      json['phone'] as String? ?? 'No Phone Found',
      json['mail'] as String? ?? 'No Mail Found',
      
    );
  }

  Map<String, dynamic> toJson() => {
    'museumName': museumName,
    'questTitle': questTitle,
    'imageUrl': imageUrl,
    'mapExterior': mapExterior,
    'mapInterior1': mapInterior1,
    'mapInterior2': mapInterior2,
    'mapInterior3': mapInterior3,
    'description': description,
    'city': city,
    'address': address,
    'webURL': webURL,
    'phone': phone,
    'mail': mail,
  };
}