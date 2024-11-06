List<List<T>> chunk<T>(List<T> list, int chunkSize) {
  List<List<T>> chunks = [];
  for (int i = 0; i < list.length; i += chunkSize) {
    int end = (i + chunkSize < list.length) ? i + chunkSize : list.length;
    List<T> chunk = list.sublist(i, end).toList(); // 使用 toList() 方法创建子列表
    chunks.add(chunk);
  }
  return chunks;
}
