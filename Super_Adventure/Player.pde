
public class Player extends AnimatedSprite {
  int lives;
  boolean onPlatform, inPlace;
  PImage[] standLeft;
  PImage[] standRight;
  PImage[] jumpLeft;
  PImage[] jumpRight;
  
  public Player(PImage img, float scale) {
    super(img,scale);
    lives = 3;
    direction = RIGHT_FACING;
    onPlatform = true;
    inPlace = true;
    standLeft = new PImage[1];
    standLeft[0] = loadImage("data/blocky/blocky_left.png");
    standRight = new PImage[1];
    standRight[0] = loadImage("data/blocky/blocky_right.png");
    jumpLeft = new PImage[1];
    jumpLeft[0] = loadImage("data/blocky/blocky_walkleft3.png");
    jumpRight = new PImage[1];
    jumpRight[0] = loadImage("data/blocky/blocky_walkright3.png");
    moveLeft = new PImage[4];
    moveLeft[0] = loadImage("data/blocky/blocky_walkleft1.png");
    moveLeft[1] = loadImage("data/blocky/blocky_walkleft2.png");
    moveLeft[2] = loadImage("data/blocky/blocky_walkleft3.png");
    moveLeft[3] = loadImage("data/blocky/blocky_walkleft4.png");
    moveRight = new PImage[4];
    moveRight[0] = loadImage("data/blocky/blocky_walkright1.png");
    moveRight[1] = loadImage("data/blocky/blocky_walkright2.png");
    moveRight[2] = loadImage("data/blocky/blocky_walkright3.png");
    moveRight[3] = loadImage("data/blocky/blocky_walkright4.png");
    currentImages = standRight;
  }
  
  @Override
  public void updateAnimation() {
   
    onPlatform = isOnPlatforms(this, platforms);
    inPlace = change_x == 0 &&  change_y == 0;
    super.updateAnimation();
  }
  
  @Override
  public void selectDirection() {
   if(change_x > 0) {
     direction = RIGHT_FACING;
   }
   else if(change_x < 0) {
     direction = LEFT_FACING;
   }
  }
  
  @Override
  public void selectCurrentImages() {
    
    if(direction == RIGHT_FACING) {
     if(inPlace) {
       currentImages = standRight;
     }
     else if(!onPlatform) {
       currentImages = jumpRight;
     }
     else {
      currentImages = moveRight; 
     }
    }
    else if(direction == LEFT_FACING) {
     if(inPlace) {
       currentImages = standLeft;
     }
     else if(!onPlatform) {
       currentImages = jumpLeft;
     }
     else {
      currentImages = moveLeft; 
     }
    }
    
  }
  
  
  
}
