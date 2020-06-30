extension TagsString on String {
  static String separator = ' ';

  List<String> toTagList() => split(separator);

  String fromTagList(List<String> tagList) => tagList.join(separator);
}
