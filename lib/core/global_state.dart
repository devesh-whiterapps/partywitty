class GlobalState {
  // 1. Private static variable to hold the single instance.
  static GlobalState? _instance;

  // 2. Public static getter to provide global access to the instance.
  //    The '??=' operator ensures the instance is created only once (lazily).
  static GlobalState get instance => _instance ??= GlobalState._internal();
  
  // 3. Private constructor to prevent external instantiation 
  //    (i.e., you cannot use 'new GlobalState()').
  GlobalState._internal();

  // --- Example Singleton Methods/Properties ---
 String videoUrl = '';
}