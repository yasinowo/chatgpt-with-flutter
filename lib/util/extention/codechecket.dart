// List<String> codeChecker(String markdownMessage) {
//   RegExp codeBlockRegex = RegExp(r'`(.*?)`', dotAll: true);
//   List<String> codeBlocks = [];
//   markdownMessage = markdownMessage.replaceAllMapped(codeBlockRegex, (match) {
//     codeBlocks.add(match.group(1)!);
//     return 'CODE_BLOCK_${codeBlocks.length - 1}';
//   });

//   List<String> parts = markdownMessage.split('CODE_BLOCK_');
//   return parts; // برگرداندن لیست parts
// }
