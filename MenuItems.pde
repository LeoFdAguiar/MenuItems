MenuButton MB, MB1, back, back1;
ArrayList<MenuButton> buttons = new ArrayList<MenuButton>();
int scene;

void setup(){
    size(800, 800, P2D);   
    
    scene = 0;
    
    MB = new MenuButton(width/2, height/2 - 50, 3, "Sample 1", 1, 0);
    MB.setPrimary(51, 51, 51);
    MB.setSecondary(168, 246, 255);
    
    MB1 = new MenuButton(width/2, height/2 + 50, 3, "Sample 2", 2, 0);
    back = new MenuButton(width/2, height/2 + 100, 2, "Back", 0, 1);
    back1 = new MenuButton(width/2, height/2 + 100, 2, "Back", 0, 2);
    
    buttons.add(MB);
    buttons.add(MB1);
    buttons.add(back);
    buttons.add(back1);
    
    MB1.setSecondary(248, 255, 127);
}

void draw(){
    changeScene();
    switch(scene){
        case 0:
            scene0();
            break;
        case 1:
            scene1();
            break;
        case 2:
            scene2();
            break;
    }
}

void scene0(){
    background(200);
    MB.show();
    MB1.show();
}

void scene1(){
    background(51);
    fill(255);
    text("This is scene #1", width/2, height/2);
    back.show();
}

void scene2(){
    background(51);
    fill(255);
    text("This is scene #2", width/2, height/2);
    back1.show();
}

void changeScene(){
    for (MenuButton m : buttons){
      int tempVal = m.getScene();
      if (tempVal >= 0){
        scene = tempVal;
        break;
      }
    }
}

void mousePressed(){
    for (MenuButton m : buttons){
      m.setClicked(scene);
    }
}
