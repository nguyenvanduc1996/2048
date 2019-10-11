import 'package:shared_preferences/shared_preferences.dart';

List operate(List<int> row,int score,SharedPreferences sharedPref){
  row = slide(row);
  List result = combine(row,score,sharedPref);
  int sc=result[0];
  row = result[1];
  row = slide(row);

  print('from func ${sc}');
  return [sc,row];
}

List<int> filter(List<int> row){
  List<int> temp = [];
  for(int i=0;i<row.length;i++){
    if(row[i] != 0){
      temp.add(row[i]);
    }
  }
  return temp;
}

List<int> slide(List<int> row){
  List<int> arr = filter(row);
  int missing = 4-arr.length;
  List<int> zeroes = zeroArray(missing);
  arr = zeroes + arr;
  return arr;
}

List<int> zeroArray(int length){
  List<int> zeroes = [];
  for(int i=0;i<length;i++){
    zeroes.add(0);
  }
  return zeroes;
}


List combine(List<int> row,int score,SharedPreferences sharedPref) {
  for (int i = 3; i >= 1; i--) {
    int a = row[i];
    int b = row[i - 1];
    // Neu thang ben trai bang thang ben phai
    if (a == b) {
      // Thang ben phai bang tong cua no voi thang ben trai
      row[i] = a + b;
      // tang diem bang cach + voi gia tri cua o ben trai hoac phai
      score += row[i];
      // Luu diem
      int sc = sharedPref.getInt('high_score');
      // Neu chua luu diem lan nao thi luu lan dau
      if(sc == null){
        sharedPref.setInt('high_score', score);
      }else {
        // neu da luu diem truoc kia thi update
        if(score > sc) {
          sharedPref.setInt('high_score', score);
        }
      }
      // xoa thang ben phai vi da hop nhat voi thang ben trai
      row[i - 1] = 0;
     
    }
  }
  return [score,row];
}

bool isGameWon(List<List<int>> grid) {
  // Lap lai tat ca cac o, neu co 1 o bang gia tri 2048 thi thang luon
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      if (grid[i][j] == 2048) {
        return true;
      }
    }
  }
  return false;
}


bool isGameOver(List<List<int>> grid) {
  // Lap lai het cac o, neu khong con o trong thi thua luon
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      if (grid[i][j] == 0) {
        return false;
      }
      if (i != 3 && grid[i][j] == grid[i + 1][j]) {
        return false;
      }
      if (j != 3 && grid[i][j] == grid[i][j + 1]) {
        return false;
      }
    }
  }
  return true;
}