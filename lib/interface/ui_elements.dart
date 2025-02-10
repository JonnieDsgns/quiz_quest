import 'package:flutter/material.dart';

class TitleSection extends StatelessWidget {
  const TitleSection({
    super.key, 
    required this.title, 
    required this.subtitle
  });
  
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) { // Definiert die Sektion unter dem Bild der Detailseite eines Museums, beinhaltet Museumsname, QuestTitel
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0,
                      ),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontStyle: FontStyle.italic,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.star),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Added to favorites'), 
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
          ],
        )
      ),
    );
  }
}

class ImageSection extends StatelessWidget {  // Dieses Widget ist das Bild für die DetailView, die sich nach dem Tippen/Klicken auf eines der Items in der Hauptansicht öffnet
  const ImageSection({
    super.key, 
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Image.network(
        imageUrl,
        height: 350,
        fit: BoxFit.cover,
      ),
    );
  }
}

class InfoSection extends StatelessWidget {
  const InfoSection({super.key, required this.description, required this.museumName, required this.city, required this.address, required this.webURL, required this.phone, required this.mail});

  final String description;
  final String museumName;
  final String city;
  final String address;
  final String webURL;
  final String phone;
  final String mail;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 7,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Expanded(
                  child: Text(
                    description,
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.perm_identity),
                title: Text(museumName),
              ),
              ListTile(
                leading: const Icon(Icons.location_city),
                title: Text(city),
              ),
              ListTile(
                leading: const Icon(Icons.place),
                title: Text(address),
              ),
              ListTile(
                leading: const Icon(Icons.language),
                title: Text(webURL),
              ),
              ListTile(
                leading: const Icon(Icons.phone),
                title: Text(phone),
              ),
              ListTile(
                leading: const Icon(Icons.mail),
                title: Text(mail),
              ),
            ],
          ),
        )
      ],
    );
  }

}