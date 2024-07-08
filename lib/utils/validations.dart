class Validations {
  Validations({this.value});

  String? value;
  List<String> _errors = [];

  Validations required({String msg = 'Field is required'}) {
    if (value == null || value!.isEmpty) _errors.add(msg);

    return this;
  }

  String? validate() {
    return _errors.firstOrNull;
  }
}
