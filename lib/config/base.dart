


class Doc {
  final String message;
  const Doc({required this.message});
}




@Doc(message: "我是一个主动显示的注释")
void methed(){
}



void methed2(){
  methed();
}

