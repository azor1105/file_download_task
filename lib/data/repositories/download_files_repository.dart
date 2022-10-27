class DownloadFileRepository {
  // mp4 --> https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4
  // jpg --> https://www.thecoderpedia.com/wp-content/uploads/2020/06/Programming-Memes-Programmer-while-sleeping.jpg
  // mp3 --> https://file-examples.com/storage/febd341d226359c2099c083/2017/11/file_example_MP3_1MG.mp3
  // pdf --> https://www.africau.edu/images/default/sample.pdf

  static List<String> getResources() {
    return [
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      'https://www.thecoderpedia.com/wp-content/uploads/2020/06/Programming-Memes-Programmer-while-sleeping.jpg',
      'https://file-examples.com/storage/febd341d226359c2099c083/2017/11/file_example_MP3_1MG.mp3',
      'https://www.africau.edu/images/default/sample.pdf'
    ];
  }
}
