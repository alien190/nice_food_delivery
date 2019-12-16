class Repository {
  static final _instance = Repository._internal();

  Repository._internal();

  factory Repository() => _instance;


}
