mixin PrintLogMixin {
  void printLog(dynamic data) {
    // print(data);
    print("*******************LOG START*******************");
    if (data != null) {
      print(" ");
      print(data);
      print(" ");
    } else {
      print("No LOGS to print");
    }
  }
}
