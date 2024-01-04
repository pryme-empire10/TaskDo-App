class TodoModel {
  String title;
  // String subTitle;
  bool isChecked;
  bool isChangeContainerColor;

  TodoModel({
    required this.title,
    // required this.subTitle,
    this.isChecked = false,
    this.isChangeContainerColor  = false
  });

}
