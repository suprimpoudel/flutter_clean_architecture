extension GetPlaceHolderName on String {
  String get getPlaceHolderName {
    if (isEmpty) return "";
    var words = split(" ");
    if (words.length >= 2) {
      return (words[0][0] + words[1][0]).toUpperCase();
    } else {
      return words[0][0].toUpperCase();
    }
  }
}
