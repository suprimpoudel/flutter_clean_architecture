bool validateRegex(String textToMatch, String regexPattern, {bool caseSensitive = false}) {
  return RegExp(regexPattern, caseSensitive: caseSensitive).hasMatch(textToMatch);
}
