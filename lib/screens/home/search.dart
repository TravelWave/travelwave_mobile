import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController textController = TextEditingController();
  bool hasSomething = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 40),
            SizedBox(
              height: 60,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    hasSomething = true;
                  });
                },
                controller: textController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  prefixIcon: const Icon(Icons.location_on_outlined, size: 20),
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
              child: Image.asset('assets/404.png'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Not Found',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Sorry, the keyword you entered cannot be found, please check again or search with another keyword',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
