part of 'gpt_markdown.dart';

/// It creates a markdown widget closed to each other.
class MdWidget extends StatelessWidget {
  const MdWidget(
    this.exp,
    this.includeGlobalComponents, {
    super.key,
    required this.config,
  });

  /// The expression to be displayed.
  final String exp;

  /// Whether to include global components.
  final bool includeGlobalComponents;

  /// The configuration of the markdown widget.
  final GptMarkdownConfig config;

  @override
  Widget build(BuildContext context) {
    List<InlineSpan> list = MarkdownComponent.generate(
      context,
      exp,
      // .replaceAllMapped(
      //     RegExp(
      //       r"\\\[(.*?)\\\]|(\\begin.*?\\end{.*?})",
      //       multiLine: true,
      //       dotAll: true,
      //     ), (match) {
      //   //
      //   String body = (match[1] ?? match[2])?.replaceAll("\n", " ") ?? "";
      //   return "\\[$body\\]";
      // }),
      config,
      includeGlobalComponents,
    );
    return config.getRich(
      TextSpan(children: list, style: config.style?.copyWith()),
    );
  }
}

/// A custom table column width.
class CustomTableColumnWidth extends TableColumnWidth {
  @override
  double maxIntrinsicWidth(Iterable<RenderBox> cells, double containerWidth) {
    double width = 50;
    for (var each in cells) {
      each.layout(const BoxConstraints(), parentUsesSize: true);
      width = max(width, each.size.width);
    }
    return min(containerWidth, width);
  }

  @override
  double minIntrinsicWidth(Iterable<RenderBox> cells, double containerWidth) {
    return 50;
  }
}
