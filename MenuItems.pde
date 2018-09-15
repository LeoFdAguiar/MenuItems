MenuButton MB, MB1, back;
int scene;

void setup(){
    size(800, 800, P2D);   
    
    scene = 0;
    
    MB = new MenuButton(width/2, height/2 - 50, 3, "Sample 1", 1);
    MB.setPrimary(51, 51, 51);
    MB.setSecondary(168, 246, 255);
    
    MB1 = new MenuButton(width/2, height/2 + 50, 3, "Sample 2", 2);
    back = new MenuButton(width/2, height/2 + 50, 3, "Back", 0);
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
    }
}

void scene0(){
    background(200);
    MB.show();
    MB1.show();
}

void changeScene(){
    if (MB.getScene() >= 0){
        scene = MB.getScene();   
    }
    else if (MB1.getScene() >= 0){
        scene = MB1.getScene();   
    }
    else if (back.getScene() >= 0){
        scene = back.getScene();   
    }
    //System.out.println(scene);
}

void scene1(){
    background(51);
    back.show();
}

void mousePressed(){
    MB.setClicked();
    MB1.setClicked();
    back.setClicked();
}