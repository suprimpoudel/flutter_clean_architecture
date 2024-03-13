extension GetPlaceHolderName on String {
  String get getPlaceHolderName {
    if (isNotEmpty) {
      try {
        var splitter = split(" ");
        String fName = splitter[0];
        String sName = splitter[1];

        String a = fName.substring(0, 1);
        String b = sName.substring(0, 1);
        return (a + b).toUpperCase();
      } catch (e) {
        try {
          var splitter = split(" ");
          String fName = splitter[0];

          String a = fName.substring(0, 1);
          return a.toUpperCase();
        } catch (_) {
          return "";
        }
      }
    } else {
      return "";
    }
  }
}
