
char[] obj = new char[9];
char[] pl1 = {'X', 'O'};
int i=2;
int[] rm = new int[9];
int[] k = new int[9];
int lf = 1;
int rm1;

int n=0;
int tmp;
int lt = 9;
char rs;
int depth;
void setup()
{
  size(400, 400);
  for (int k=0; k<9; k++)
  {
    obj[k]=' ';
  }
  
}

void draw()
{
  char pl = 'X';
  background(255);
  beginShape();
  noFill();
  strokeWeight(5);
  line(width/3, 0, width/3, height);
  line(2*width/3, 0, 2*width/3, height);
  line(0, height/3, width, height/3);
  line(0, 2*height/3, width, 2*height/3);
  endShape();
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(90);
  // first row
  text(obj[0], width/6, height/6);
  text(obj[1], width/2, height/6);
  text(obj[2], 5*width/6, height/6);
  // second row
  text(obj[3], width/6, height/2);
  text(obj[4], width/2, height/2);
  text(obj[5], 5*width/6, height/2);
  // third row
  text(obj[6], width/6, 5*height/6);
  text(obj[7], width/2, 5*height/6);
  text(obj[8], 5*width/6, 5*height/6);
  frameRate(5);
  println(checkWinner());
  opponent();
}

void mouseClicked()
{
    // Sanity check that it is actually the player's turn
    if (i % 2 == 0)
        {
        // Calculate tile index
        int x = floor(mouseX / (width / 3));
        int y = floor(mouseY / (height / 3));
        int index = x + (y * 3);

    // Index directly into obj[], instead of hardcoding each tile
    if (obj[index] == ' '); // Check if empty, rather than not full
        {
            obj[index]=pl1[0];
            // Process turn counter after successfully moving,
            // instead of after unsuccessful, then again at the end
            i=i+1;
            lt--;
        }
    }
}

void opponent()
{
  if (i%2==1)
  {  
    int bestscore = -11;
    int move = 0;
    // int[] avl = new int[0]; // This line is irrelevant, possible memory leak?

    // This could be refactored into minimax(), but this works well enough, I guess
    for (int a=0; a<=8; a++)
    {
  
      if (obj[a]!='O' && obj[a]!='X')
      {
        obj[a] = pl1[1];
        lt--; // Decrement lt so that it's considered by checkWinner()
        int score = minimax(0, false);
        lt++; // Undo decrement of lt
        obj[a] = ' ';
        if (score > bestscore)
        {
          bestscore = score;
          move = a;
        }
      }
    }
    // Sanity check that a move has actually been found
    if (bestscore == -11 || bestscore == 11)
    {
        // Error!

    }
    else
    {
        obj[move] = pl1[1];
        i++;
        lt--;

        // This is block should fix the reported issue.
        // As opponent() is called at the end of draw(), redrawing the
        // window after a move should ensure it's updated
        redraw();
        // As checkWinner() triggers noLoop() whenever it reaches a terminal state,
        // loop() needs to be called if the game is continuing. Really, it would
        // be better to only call noLoop() when the game is actually over, but
        // this should be a decent workaround
        if (lt > 0)
        {
            loop();
        }
    }
  }
}

char checkWinner()
{
  rs = ' ';

  // This is a problem; lt is only modified when a move is executed,
  // so when the AI is checking for a tie, lt is never 0.
  // Easy workaround, modify lt as the AI is picking moves
  if (lt == 0)
  {
    noLoop();
    rs ='t';
  }

  // If A == B and B == C, no need to check A == C
  
  // first column
  if(obj[0]==obj[1] && obj[1]==obj[2] && obj[0]!=' ')
  {
    noLoop();
    rs =obj[0];
  }
  // second column
  if(obj[3]==obj[4] && obj[4]==obj[5] && obj[3]!=' ')
  {
    noLoop();
    rs =obj[3];
  }
  // third column
  if(obj[6]==obj[7] && obj[7]==obj[8] && obj[6]!=' ')
  {
    noLoop();
    rs =obj[6];
  }
  // first row
  if(obj[0]==obj[3] && obj[3]==obj[6] && obj[0]!=' ')
  {
    noLoop();
    rs =obj[0];
  }
  // second row
  if(obj[1]==obj[4] && obj[4]==obj[7] && obj[1]!=' ')
  {
    noLoop();
    rs =obj[1];
  }
  // third row
  if(obj[2]==obj[5] && obj[5]==obj[8] && obj[2]!=' ')
  {
    noLoop();
    rs =obj[2];
  }
  // right diagonal
  if(obj[0]==obj[4] && obj[4]==obj[8] && obj[0]!=' ')
  {
    noLoop();
    rs =obj[0];
  }
  // left diagonal
  if(obj[2]==obj[4] && obj[4]==obj[6] && obj[2]!=' ')
  {
    noLoop();
    rs =obj[2];
  }
  return rs;
}


int minimax(int depth ,boolean isMaximising)
{
  char result = checkWinner();
  if (result == 'X')
  {
    return int(10);
  }
  if (result == 'O')
  {
    return int(-10);
  }
  if (result == 't')
  {
    return int(0);
  }
  if (isMaximising)
  {
    int bestscore = -11;
    for (int a=0; a<=8; a++)
    {
  
      if (obj[a]!='O' && obj[a]!='X')
      {
        obj[a] = pl1[1];
        lt--; // Decrement lt so that it's considered by checkWinner()
        int score = minimax(depth+1, false);
        lt++; // Undo decrement of lt
        obj[a] = ' ';
        bestscore = max(score, bestscore);
      }
    }
    return bestscore;
    
  }
  else
  {
    int bestscore = 11;
    for (int a=0; a<=8; a++)
    {
  
      if (obj[a]!='O' && obj[a]!='X')
      {
        obj[a] = pl1[0];
        lt--; // Decrement lt so that it's considered by checkWinner()
        int score = minimax(depth+1, true);
        lt++; // Undo decrement of lt
        obj[a] = ' ';
        bestscore = min(score, bestscore);
      }
    }
    return bestscore;
    
  }
}
