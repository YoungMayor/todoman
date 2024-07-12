import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  final String aboutUsContent = """
## Our Mission

TaskMaster is designed to be a simple task management platform for managing simple tasks. 

We aim to provide a straightforward and efficient way for users to keep track of their to-do lists without the hassle of overly complicated features.

## Key Features

- **Offline Usage:** Access and manage your tasks even without an internet connection.
- **Simple and Easy to Use UI:** Enjoy a user-friendly interface designed to enhance productivity.
- **Unlimited Task Management:** Create, manage, and delete unlimited tasks with ease.
- **Biometric Authentication:** Secure your tasks with fingerprint authentication.
- **Intuitive UI:** Enjoy a user-friendly interface designed to enhance your productivity.

## Target Audience

TaskMaster is designed for everyone. Whether you're a student, a professional, or someone who just needs to keep track of daily tasks, TaskMaster is the perfect tool for you.

## Development Story

TaskMaster is a training app and the first project I developed using Flutter. It has been an exciting journey, learning and overcoming various challenges along the way. This app represents not only a functional tool but also my growth as a developer.

## Developer

**Meyoron Aghogho**

- **Email:** youngmayor.dev@gmail.com
- **Company:** Mayor Technology
- **Experience:** 6 years in software engineering

I am passionate about creating efficient and user-friendly software solutions. TaskMaster is a testament to my dedication and skill in the field of software development.

## Contact Us

For support and inquiries, please contact us at:

- **Phone:** [+2348075178485](tel:+2348075178485)
- **Email:** youngmayor.dev@gmail.com
- **Website:** [https://youngmayor.com.ng](https://youngmayor.com.ng)

## Future Plans

We are continuously working to improve TaskMaster. Here are some features you can look forward to in future updates:

- **Deadlines:** Set deadlines for your tasks to ensure timely completion.
- **Calendar Reminders:** Get reminders for your tasks on your calendar.
- **Categorisation:** Organise your tasks into categories for better management.
- **Cloud Storage:** Sync your tasks across devices with cloud storage.

Thank you for choosing TaskMaster to help manage your tasks!

""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About TaskMaster"),
        centerTitle: true,
      ),
      body: Builder(builder: (context) {
        ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Markdown(
            data: aboutUsContent,
            styleSheet: MarkdownStyleSheet(
              p: const TextStyle(fontSize: 16),
              h2: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              h2Align: WrapAlignment.center,
              h2Padding: const EdgeInsets.only(top: 30),
            ),
            onTapLink: (text, url, title) async {
              if (url != null) {
                if (!await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(
                    Uri.parse(url),
                    mode: LaunchMode.externalApplication,
                  );
                } else {
                  Clipboard.setData(ClipboardData(text: text));

                  messenger.showSnackBar(const SnackBar(
                    content: Text("Link copied to clipboard"),
                  ));
                }
              }
            },
          ),
        );
      }),
    );
  }
}
