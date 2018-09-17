MenuButton MB, MB1, back, back1;
ArrayList<MenuButton> buttons = new ArrayList<MenuButton>();
int scene;

void settings(){
    size(800, 800, P2D);
}

void setup(){
    
    scene = 0;

    //Create buttons for the sketch.
    MB = new MenuButton(width/2, height/2 - 50, 3, "Sample 1", 1, 0);
    //Change colors of the first button.
    MB.setPrimary(51, 51, 51);
    MB.setSecondary(168, 246, 255);

    MB1 = new MenuButton(width/2, height/2 + 50, 3, "Sample 2", 2, 0);
    back = new MenuButton(width/2, height/2 + 100, 2, "Back", 0, 1);
    back1 = new MenuButton(width/2, height/2 + 100, 2, "Back", 0, 2);

    //Add buttons to array for easy looping.
    buttons.add(MB);
    buttons.add(MB1);
    buttons.add(back);
    buttons.add(back1);

    MB1.setSecondary(248, 255, 127);
}

/**
* Draw current the scene.
*/
void draw(){
    changeScene();
    //Draw appropriate scene.
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

/**
* Main scene.
*/
void scene0(){
    background(200);
    MB.show();
    MB1.show();
}

/**
* Sample scene 1
*/
void scene1(){
    background(51);
    fill(255);
    text("This is scene #1", width/2, height/2);
    back.show();
}

/**
* Sample scene 2
*/
void scene2(){
    background(51);
    fill(255);
    text("This is scene #2", width/2, height/2);
    back1.show();
}

/**
* Get the possible scene change from the buttons.
*/
void changeScene(){
    //Loop through all buttons.
    for (MenuButton m : buttons){
        //Grab temp scene val
        int tempVal = m.getScene();
        //If it is positive we know we have a scene change.
        if (tempVal >= 0){
            //Update scene.
            scene = tempVal;
            break;
        }
    }
}

/**
* Call the click method with each button when the mouse is clicked.
*/
void mousePressed(){
    for (MenuButton m : buttons){
        m.setClicked(scene);
    }
}
