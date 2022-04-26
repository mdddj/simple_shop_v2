


class Doc {
  final String message;
  const Doc({required this.message});
}




@Doc(message: "我是一个会被主动显示的注释")
void methed(){
}

void methed3(){
  
}


void methed2(){
  methed();
  methed3();
}

