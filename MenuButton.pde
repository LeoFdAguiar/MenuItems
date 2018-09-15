public class MenuButton{
    float x, y, w, h, scale, aWidth, speed, c1Width, c2Width, rect1X;
    int scene, currentScene;
    color primary, secondary;
    String text;
    boolean clicked, hovered, animationFinished;
    
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
    
    public void animateHover(){
        if (isHovered()){
            if (aWidth < w)
                aWidth += speed;
            if (aWidth > w)
                aWidth = w;
        }
        else{
            if(aWidth > 0)
                aWidth -= speed; 
            if(aWidth < 0)
                aWidth = 0;
        }
        
        if (aWidth > 0){
            rectMode(CORNER);
            fill(secondary);
            rect((x - w/2), y - (h/2), aWidth, h); 
        }
    }
    
    public void setClicked(int s){
        c1Width = 0;
        c2Width = 0;
        if (isHovered() && s == currentScene){
            clicked =  true;
            rect1X = mouseX;
        }
    }
    
    public int getScene(){
        if (animationFinished){
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
    
    public void animateClick(){
        float rect1Y = y - (h/2);
        float rect1Speed = ((w - (rect1X - (x - w/2))) / w) * speed;
        float maxRect1 = w - (rect1X - (x - (w/2)));
        float maxRect2 = (w - maxRect1) * -1;
        
        if (clicked){ 
            if (rect1X + c1Width < (x - (w/2)) + w){
                c1Width += rect1Speed; 
                c2Width -= speed - rect1Speed;
            }
            
            //Bound the animation to the size of the original bar.
            if (c1Width > maxRect1){
                c1Width = maxRect1;   
                animationFinished = true;
            }
            if (c2Width < maxRect2){
                c2Width = maxRect2;   
                animationFinished = true;
            }
            
            fill(primary);
            rectMode(CORNER);
            rect(rect1X, rect1Y, c1Width, h);
            rect(rect1X, rect1Y, c2Width, h);
        }
    }
    
    public void setPrimary(int r, int g, int b){
        primary = color(r, g, b);
    }
    
    public void setSecondary(int r, int g, int b){
        secondary = color(r, g, b);
    }
    
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
