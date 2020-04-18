String countryCodeToEmoji(String countryCode) {
  final int unicodeOffset = 127397;

  countryCode = countryCode.toUpperCase();

  if (countryCode == "UK") {
    countryCode = "GB";
  }

  var codeunits = countryCode.codeUnits;
  codeunits = codeunits.map((char) {
    return char + unicodeOffset;
  }).toList();

  return String.fromCharCodes(codeunits);
}
