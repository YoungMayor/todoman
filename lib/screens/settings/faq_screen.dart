import 'package:flutter/material.dart';
import 'package:todoman/data/faq_data.dart';

class FAQScreen extends StatelessWidget {
  FAQScreen({super.key});

  final List<FAQDataModel> _payload = FAQData.payload;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Frequently Asked Questions"),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: _payload.length,
        itemBuilder: (context, index) {
          FAQDataModel model = _payload[index];

          return ListTile(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                model.question,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            subtitle: Text(model.answer),
            leading: Transform.rotate(
              angle: 1.5708,
              child: Text(
                "Q${index + 1}.",
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(
          height: 40,
          thickness: 0.5,
          indent: 15,
          endIndent: 15,
          color: Colors.black,
        ),
      ),
    );
  }
}
