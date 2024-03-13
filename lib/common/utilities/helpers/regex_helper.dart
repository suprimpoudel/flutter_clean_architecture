bool validateRegex(String textToMatch, String regexPattern,
    {bool? caseSensitive}) {
  RegExp nameRegex =
      RegExp(regexPattern, caseSensitive: caseSensitive ?? false);
  if (!nameRegex.hasMatch(textToMatch)) {
    return false;
  } else {
    return true;
  }
}
