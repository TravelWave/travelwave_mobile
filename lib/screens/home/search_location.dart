import 'package:flutter/material.dart';
import 'package:travelwave_mobile/repositories/search_repository.dart';

class LocationSearch extends StatefulWidget {
  const LocationSearch({super.key});

  @override
  State<LocationSearch> createState() => _LocationSearchState();
}

class _LocationSearchState extends State<LocationSearch> {
  TextEditingController textController = TextEditingController();
  bool hasSomething = false;
  List suggestions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 40),
              SizedBox(
                height: 60,
                child: TextField(
                  onChanged: (value) async {
                    if (value.isEmpty) {
                      suggestions = [];
                    } else {
                      suggestions = await SearchRepository.searchPlaces(value);
                    }
                    setState(() {
                      hasSomething = true;
                    });
                  },
                  controller: textController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    prefixIcon:
                        const Icon(Icons.location_on_outlined, size: 20),
                    suffixIcon: hasSomething
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                textController.clear();
                                hasSomething = false;
                              });
                              FocusScope.of(context).unfocus();
                            },
                            icon: Icon(Icons.clear, color: Colors.grey[800]),
                          )
                        : null,
                    filled: true,
                    fillColor: const Color(0xFFFFF1B1),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey[800]!,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                height: 500,
                width: 400,
                child: Expanded(
                  child: ListView.builder(
                    itemCount: suggestions.length,
                    itemBuilder: (context, index) {
                      final place = suggestions[index];
                      return GestureDetector(
                        onTap: () {
                          textController.text = place['display_name'];
                          suggestions = [];
                          setState(() {});
                          Navigator.pop(context, textController.text);
                        },
                        child: ListTile(
                          title: LocationCard(
                            placeName: parseLocation(
                                place['display_name'])['placeName']!,
                            address: parseLocation(
                                place['display_name'])['address']!,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Map<String, String> parseLocation(String locationString) {
  final parts = locationString.split(',');
  if (parts.length < 3) {
    return {'placeName': locationString, 'address': ''};
  }

  final placeName = parts.sublist(0, 3).join(', ');
  final address = parts.skip(3).join(', ');

  return {'placeName': placeName, 'address': address};
}

class LocationCard extends StatelessWidget {
  final String placeName;
  final String address;

  const LocationCard({
    super.key,
    required this.placeName,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              placeName,
              style:
                  const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4.0),
            Text(
              address,
              style: const TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
