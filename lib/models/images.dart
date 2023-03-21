class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent(
      {required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Chào mừng đến với FSOS',
      image: 'assets/icons/logo.png',
      discription: "Luôn đặt sự an toàn lên hàng đầu"),
  UnbordingContent(
      title: 'Chào mừng đến với FSOS',
      image: 'assets/icons/logo.png',
      discription: "Luôn bên cạnh bạn"),
  UnbordingContent(
      title: 'Chào mừng đến với FSOS',
      image: 'assets/icons/logo.png',
      discription: "Tạo sự an toàn cho khách hàng"),
];
