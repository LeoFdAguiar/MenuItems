public class MenuButton{
    float x, y, w, h, scale, aWidth, speed, c1Width, c2Width, rect1X;
    int scene, currentScene;
    color primary, secondary;
    String text;
    boolean clicked, hovered, animationFinished;

    /**
     * Constuctor for the MenuButton class. Button is drawn from the center
     * @param x            X pos for the button to be displayed.
     * @param y            Y pos for the button to be displayed.
     * @param scale        Scale the buttons up (above 1) if they are too small.
     * @param text         Text to display in the button
     * @param scene        Scene you wish to transition to.
     * @param currentScene Scene the button currently lives in.
     */
    public MenuButton(float x, float y, float scale, String text, int scene, int currentScene){
        this.x = x;
        this.y = y;
        this.aWidth = 0;
        this.c1Width = 0;
        this.c2Width = 0;
        this.scene = scene;
        this.currentScene = currentScene;
        this.text = text;
        this.scale = scale;
        this.speed = 12 * scale;
        this.w = 150 * scale;
        this.h = 23 * scale;
        this.primary = color(0,0,0);
        this.secondary = color(255, 255, 255);
        this.clicked = false;
        this.hovered = false;
        this.animationFinished = false;

        PFont font = createFont("AppleSDGothicNeo-Thin-48.vlw", 80);
        textFont(font);
    }

    /**
     * Animation for when the cursor is hovered over the button.
     */
    public void animateHover(){
        //Is the cursor over the button? If so expand the animation rect.
        if (isHovered()){
            //Make sure the animation rect stops growing when it is larger than
            //the button width.
            if (aWidth < w)
                aWidth += speed;
            //Snap the animation rect to the width of the button if it is too large.
            if (aWidth > w)
                aWidth = w;
        }
        //If we are not hovered over the button then shrink the animation rect.
        else{
            //Make sure the animation rect stops shrinking when it is smaller than 0
            if(aWidth > 0)
                aWidth -= speed;
            //Snap the animation rect to the width of the button if it is too small.
            if(aWidth < 0)
                aWidth = 0;
        }

        //Simply draw the rect if it is larger than 0
        if (aWidth > 0){
            rectMode(CORNER);
            fill(secondary);
            rect((x - w/2), y - (h/2), aWidth, h);
        }
    }

    /**
     * Display a click if the button is actually clicked
     * @param s [description]
     */
    public void setClicked(int s){
        //Reset click animation size.
        c1Width = 0;
        c2Width = 0;
        //If the mouse is over the button and we are in the current scene of the
        //button.
        if (isHovered() && s == currentScene){
            clicked =  true;
            //Set position for the animation.
            rect1X = mouseX;
        }
    }

    /**
     * Gets the new scene the button wants to transfer to when it is done with its
     * animation.
     * @return -1 if the scene should not be changed else some positive number
     * representing the scene that the main scene should change to.
     */
    public int getScene(){
        //Make sure the click animation is finished.
        if (animationFinished){
            //Reset animations and other variables.
            c1Width = 0;
            c2Width = 0;
            aWidth = 0;
            animationFinished = false;
            clicked = false;
            return scene;
        }
        else
            return -1;
    }

    /**
     * Displays the click animation for the button. This is basically 2 rectangles
     * growing in opposite directions of each other.
     */
    public void animateClick(){
        //Get Y value for the new rectangles.
        float rect1Y = y - (h/2);
        //Get the speed based on how close the rectangle is to an egde.
        float rect1Speed = ((w - (rect1X - (x - w/2))) / w) * speed;
        //Width of the first rectangle.
        float maxRect1 = w - (rect1X - (x - (w/2)));
        //Width of the second rectangle.
        float maxRect2 = (w - maxRect1) * -1;

        //Make sure we clicked the button.
        if (clicked){
            //If we havent hit the edge of the button continue to animate.
            if (rect1X + c1Width < (x - (w/2)) + w){
                c1Width += rect1Speed;
                c2Width -= speed - rect1Speed;
            }

            //Bound the animation to the size of the original bar.
            if (c1Width > maxRect1){
                c1Width = maxRect1;
                //Let the button know that it is done animating so it can change scenes.
                animationFinished = true;
            }

            //Draw the animations.
            fill(primary);
            rectMode(CORNER);
            rect(rect1X, rect1Y, c1Width, h);
            rect(rect1X, rect1Y, c2Width, h);
        }
    }

    /**
     * Change the primary color of the button (RGB)
     * @param r red
     * @param g green
     * @param b blue
     */
    public void setPrimary(int r, int g, int b){
        primary = color(r, g, b);
    }

    /**
     * Change the secondary color of the button (RGB)
     * @param r red
     * @param g green
     * @param b blue
     */
    public void setSecondary(int r, int g, int b){
        secondary = color(r, g, b);
    }

    //Display the button to the screen.
    public void show(){
        noStroke();

        fill(primary);
        rectMode(CENTER);
        rect(x, y, w, h);

        animateHover();
        animateClick();

        if (aWidth > w/2)
            fill(primary);
        else
            fill(secondary);

        textSize(12 * scale);
        textAlign(CENTER);
        text(text, x, y + (3 * scale));
    }

    /**
     * Check to see if the mouse is hovered over the button.
     * @return [description]
     */
    public boolean isHovered(){
        if (mouseX > x - w/2 && mouseX < x + w/2){
            if (mouseY > y - h/2 && mouseY < y + h/2){
                hovered = true;
                cursor(HAND);
                return true;
            }
        }
        
        if(hovered)
            cursor(ARROW);

        hovered = false;
        return false;
    }

}
