class FAQDataModel {
  const FAQDataModel({required this.question, required this.answer});

  final String question, answer;
}

class FAQData {
  static final List<FAQDataModel> payload = [
    const FAQDataModel(
      question: 'What is TaskMaster?',
      answer:
          'TaskMaster is a simple task management platform designed to help you manage and track your tasks efficiently.',
    ),
    const FAQDataModel(
      question: 'Who is TaskMaster for?',
      answer:
          'TaskMaster is for anyone who needs to keep track of their tasks, whether you\'re a student, professional, or anyone else with tasks to manage.',
    ),
    const FAQDataModel(
      question: 'Can I use TaskMaster offline?',
      answer:
          'Yes, TaskMaster can be used offline, allowing you to access and manage your tasks even without an internet connection.',
    ),
    const FAQDataModel(
      question: 'What features does TaskMaster offer?',
      answer:
          'TaskMaster offers features such as unlimited task management, a simple and easy-to-use interface, and offline usage. Future updates will include deadlines, calendar reminders, categorisation, and cloud storage.',
    ),
    const FAQDataModel(
      question: 'Is TaskMaster free to use?',
      answer: 'Yes, TaskMaster is free to use.',
    ),
    const FAQDataModel(
      question: 'How do I create a new task?',
      answer:
          'To create a new task, tap the \'+\' icon on the main screen and fill in the task details.',
    ),
    const FAQDataModel(
      question: 'How do I mark a task as completed?',
      answer:
          'To mark a task as completed, tap on the task and it will be marked as done. You can tap it again to mark it as incomplete.',
    ),
    const FAQDataModel(
      question: 'How do I delete a task?',
      answer:
          'You can delete a task by clicking the trash icon at the end of it and confirming the action. Becareful as this cannot be undone!',
    ),
    const FAQDataModel(
      question: 'How can I contact support?',
      answer:
          'For support, you can contact us via email at youngmayor.dev@gmail.com or phone at +2348075178485.',
    ),
    const FAQDataModel(
      question: 'Who developed TaskMaster?',
      answer:
          'TaskMaster was developed by Meyoron Aghogho of Mayor Technology. Meyoron has 6 years of experience in software engineering.',
    ),
  ];
}
