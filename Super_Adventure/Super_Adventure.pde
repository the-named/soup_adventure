final static float MOVE_SPEED = 5;
final static float SPRITE_SCALE = 50.0/128;
final static float SPRITE_SIZE = 50;
final static float GRAVITY = 0.6;
final static float JUMP_SPEED = 15;
final static float RIGHT_MARGIN = 400;
final static float LEFT_MARGIN = 60;
final static float VERTICAL_MARGIN = 40;

final static int NEUTRAL_FACING = 0;
final static int RIGHT_FACING = 1;
final static int LEFT_FACING = 2;

final static float WIDTH = SPRITE_SIZE * 16;
final static float HEIGHT = SPRITE_SIZE *12;
final static float GROUND_LEVEL = HEIGHT - SPRITE_SIZE;

/*
Section 1: Here we will be practicing declaring various data types and performing expression
statements for our game to work. You will be provided with 
the names of the variables, the values
to give them, expressions, and the data types for each.

Declare  an int named score, a boolean named isGameOver and 2 floats named view_x and view_y */


/* -------------------------- */

/* Section 2 part 2: Declare 2 string variables to be used later. 

Declare a string named coinPhrase and livePhrase
*/


/*-----------------------*/
Player player;
PImage rock_block, sand_block, marble_block, stone_block, grass_block, dirt_block, gold, spider, p, flame;
ArrayList<Sprite> platforms;
ArrayList<Sprite> coins;
ArrayList<Sprite> enemies;

//initialize here
void setup() {
  
  size(800,600);
  imageMode(CENTER);
  score = 0;
  p = loadImage("data/blocky/blocky_right.png");
  /* Section 2 part 1 Call player constructor and initalize variables
  Will be given the values and variables to update. Will also call method with parameter
  
  Call the constructor Player(p,SPRITE_SCALE) with those parameters. It should be set equal to the player variable
  */
 
 
 
  /*----------------------*/
  player.change_x = 0;
  player.change_y = 0;
  player.setBottom(GROUND_LEVEL);
  player.center_x = 100;
  
  rock_block = loadImage("data/rock_block.png");
  sand_block = loadImage("data/sand_block.png");
  marble_block = loadImage("data/marble_block.png");
  stone_block = loadImage("data/stone_block.png");
  grass_block = loadImage("data/grass_block.png");
  dirt_block = loadImage("data/dirt_block.png");
  gold = loadImage("data/gold_1.png");
  spider = loadImage("data/spider_walk_right1.png");
  
  platforms = new ArrayList<Sprite>();
  coins = new ArrayList<Sprite>();
  enemies = new ArrayList<Sprite>();
  createPlatforms("data/starter-map.csv");
  
  view_x = view_y = 0;
  isGameOver = false;

}

//modify and update
void draw() {
  background(255);
  scroll();
  displayAll();
  
  if(!isGameOver) {
    updateAll();
  }
}

void scroll() {
 
  float right_boundary = view_x + width - RIGHT_MARGIN;
  if(player.getRight() > right_boundary) {
    view_x += player.getRight() - right_boundary;
  }
  
  float left_boundary = view_x + LEFT_MARGIN;
  if(player.getLeft() < left_boundary) {
    view_x -= left_boundary - player.getLeft();
  }
  
  float bottom_boundary = view_y + height - VERTICAL_MARGIN;
  if(player.getBottom() > bottom_boundary) {
    view_y += player.getBottom() - bottom_boundary;
  }
  
  float top_boundary = view_y + VERTICAL_MARGIN;
  if(player.getTop() < top_boundary) {
    view_y -= top_boundary - player.getTop();
  }
  
  translate(-view_x, -view_y);
}

public void displayAll() {
    player.display();

    
    for(Sprite s:platforms) {
      s.display();
    }
    
    for(Sprite c:coins) {
      c.display();
    }
    for(Sprite enemy:enemies){
      enemy.display();
    }
    
    

    fill(255,0,0);
    textSize(32);
    coinPhrase = "Coins:" + score;
    livePhrase = "Lives:" + player.lives;
    text(coinPhrase, view_x + 50, view_y + 50);
    text(livePhrase, view_x + 50, view_y + 100);
    
    if(isGameOver) {
      fill(0,0,255);
      text("GAME OVER!", view_x + width/2 - 100, view_y + height/2);
      if(player.lives == 0) {
        text("You lose!", view_x + width/2 - 100, view_y + height/2 + 50);
      }
      else {
        text("You win!", view_x + width/2 - 100, view_y + height/2 + 50);
      }
      text("Press SPACE to restart!", view_x + width/2 - 100, view_y + height/2 + 100);
    } 
   
}

public void updateAll() {
    for(Sprite c:coins) {
      ((AnimatedSprite)c).updateAnimation();
    }
    
    for(Sprite enemy:enemies) {
     enemy.update();
     ((AnimatedSprite)enemy).updateAnimation();
    }
    

    player.updateAnimation();
    resolvePlatformCollisions(player,platforms);
    resolveCoinCollisions(player,coins);
    checkDeath();
}


// called when key is pressed
void keyPressed() {
  /*Section 3: If statements and control flow
  Will construct the logic to complete the key pressed function using if statements
  
  Fill in the If statements, one is done for you and the remaining are the other directions. They only require
  the directions in order: RIGHT, LEFT, UP, & DOWN
  */
  if() {
     player.change_x = MOVE_SPEED; 
  }
   else if() {
     player.change_x = -MOVE_SPEED; 
  }
   else if(keyCode == UP && isOnPlatforms(player,platforms)) {
     player.change_y = -JUMP_SPEED; 
  }
   else if() {
     player.change_y = MOVE_SPEED; 
  }
  else if(isGameOver && key == ' ') {
    setup();
  }
  /*----------------------------*/
}

//called when key is released
void keyReleased() {
  /* Section 3: If statements will complete the key released function
    Fill these in same as above the order is: RIGHT, LEFT, DOWN
  */
    if() {
     player.change_x = 0; 
  }
   else if() {
     player.change_x = 0; 
  }
   else if() {
     player.change_y = 0; 
  }
  /*----------------------------*/
}

void createPlatforms(String filename) {
  /* Section 4: We will be constructing the for loops needed to create
  the platforms 
  
  Initialize the first for loop with row starting at 0, it going while it is less than 
  lines.length, and increment row by 1
  
  Initialize the second for loop with col starting at 0, it going while it is less than 
  values.length, and increment col by 1
  
  */
  String[] lines = loadStrings(filename);
  /* First for loop */
  for() {
    String[] values = split(lines[row],",");
    /* Second for loop */
    for() {
      if(values[col].equals("m")) {
         Sprite s = new Sprite(marble_block,SPRITE_SCALE);
         s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
         s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
         platforms.add(s);
      }
      else if(values[col].equals("g")) {
        Sprite s =  new Sprite(grass_block, SPRITE_SCALE);
        s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        platforms.add(s);
      }
       else if(values[col].equals("r")) {
        Sprite s =  new Sprite(rock_block, SPRITE_SCALE);
        s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        platforms.add(s);
      }
       else if(values[col].equals("s")) {
        Sprite s =  new Sprite(sand_block, SPRITE_SCALE);
        s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        platforms.add(s);
      }
       else if(values[col].equals("x")) {
        Coin c =  new Coin(gold, SPRITE_SCALE);
        c.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        c.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        coins.add(c);
      }
      else if(values[col].equals("0")) {
        continue;
      }
       else {
        int walk_length = int(values[col]);
        float bLeft = col * SPRITE_SIZE;
        float bRight = bLeft + walk_length * SPRITE_SIZE;
        Enemy enemy =  new Enemy(spider, 50/72.0, bLeft, bRight);
        enemy.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        enemy.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        enemies.add(enemy);
      }
    }
  }
  /*--------------------*/
}

boolean checkCollision(Sprite s1, Sprite s2) {
 
  boolean isXNotOverlap = s1.getRight() <= s2.getLeft() || s1.getLeft() >= s2.getRight();
  boolean isYNotOverlap = s1.getBottom() <= s2.getTop() || s1.getTop() >= s2.getBottom();
  
  if(isXNotOverlap || isYNotOverlap){
   return false; 
  }
  else {
    return true;
  }
}

/* Return an arraylist of sprites that collide with given sprite */
ArrayList<Sprite> checkCollisionList(Sprite s, ArrayList<Sprite> list) {
  ArrayList<Sprite> collisionList = new ArrayList<Sprite>();
  for(Sprite p: list) {
    if(checkCollision(s,p)) {
       collisionList.add(p); 
    }
  }
  return collisionList;
}


void resolvePlatformCollisions(Sprite s, ArrayList<Sprite> walls) {
  s.change_y += GRAVITY;
 
 s.center_y += s.change_y;
 ArrayList<Sprite> collisionList = checkCollisionList(s,walls);
 if(collisionList.size() > 0) {
    Sprite collided = collisionList.get(0);
    if(s.change_y > 0) {
      s.setBottom(collided.getTop());
    }
    else if(s.change_y < 0) {
      s.setTop(collided.getBottom());
    }
    s.change_y = 0;
 }
 
 
 s.center_x += s.change_x;
 collisionList = checkCollisionList(s,walls);
 if(collisionList.size() > 0) {
    Sprite collided = collisionList.get(0);
    if(s.change_x > 0) {
      s.setRight(collided.getLeft());
    }
    else if(s.change_x < 0) {
      s.setLeft(collided.getRight());
    }
    s.change_x = 0;
 }
}

void resolveCoinCollisions(Sprite s, ArrayList<Sprite> coins) {
  
 ArrayList<Sprite> collisionList = checkCollisionList(s,coins);
 if(collisionList.size() > 0) {
   for(Sprite coin: collisionList) {
    coins.remove(coin);
    score++;
   }
 }
 if(coins.size() == 0) {
   isGameOver = true;
 }
}


void checkDeath() {
 ArrayList<Sprite> collideEnemy = checkCollisionList(player,enemies);
 boolean fallOffCliff = player.getBottom() > GROUND_LEVEL;
 if(collideEnemy.size() > 0 || fallOffCliff) {
    player.lives --;
    if(player.lives == 0) {
      isGameOver = true;
    }
    else {
     player.center_x = 100;
     player.setBottom(GROUND_LEVEL);
    }
 }
}

boolean isOnPlatforms(Sprite s, ArrayList<Sprite> walls) {
  s.center_y += 5;
  ArrayList<Sprite> collisionList = checkCollisionList(s,walls);
  s.center_y -= 5;
  
  if(collisionList.size() > 0) {
    return true;
  }
  else {
    return false;
  }
}
