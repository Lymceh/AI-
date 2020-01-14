
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
  if (mouseX<width/3 && mouseY<height/3)
  {
    if (obj[0] != 'X' && obj[0] != 'O')
    {
      obj[0] = pl1[0];
    } else
    {
      i--;
    }
  }
  if (mouseX>width/3 && mouseX<2*width/3 && mouseY<height/3)
  {
    if (obj[1] != 'X' && obj[1] != 'O')
    {
      obj[1] = pl1[0];
    } else
    {
      i--;
    }
  }
  if (mouseX>2*width/3 && mouseX<width && mouseY<height/3)
  {
    if (obj[2] != 'X' && obj[2] != 'O')
    {
      obj[2] = pl1[0];
    } else
    {
      i--;
    }
  }
  if (mouseX<width/3 && mouseY>height/3 && mouseY<2*height/3)
  {
    if (obj[3] != 'X' && obj[3] != 'O')
    {
      obj[3] = pl1[0];
    } else
    {
      i--;
    }
  }
  if (mouseX>width/3 && mouseX<2*width/3 && mouseY>height/3 && mouseY<2*height/3)
  {
    if (obj[4] != 'X' && obj[4] != 'O')
    {
      obj[4] = pl1[i%2];
    } else
    {
      i--;
    }
  }
  if (mouseX>2*width/3 && mouseX<width && mouseY>height/3 && mouseY<2*height/3)
  {
    if (obj[5] != 'X' && obj[5] != 'O')
    {  
      obj[5] = pl1[i%2];
    } else
    {
      i--;
    }
  }
  if (mouseX<width/3 && mouseY>2*height/3 && mouseY<height)
  {
    if (obj[6] != 'X' && obj[6] != 'O')
    {
      obj[6] = pl1[0];
    } else
    {
      i--;
    }
  }
  if (mouseX>width/3 && mouseX<2*width/3 && mouseY>2*height/3 && mouseY<height)
  {
    if (obj[7] != 'X' && obj[7] != 'O')
    {
      obj[7] = pl1[0];
    } else
    {
      i--;
    }
  }
  if (mouseX>2*width/3 && mouseX<width && mouseY>2*height/3 && mouseY<height)
  {
    if (obj[8] != 'X' && obj[8] != 'O')
    {
      //
      obj[8] = pl1[0];
    } else
    {
      i--;
    }
  }
  i=i+1;
  lt--;
}


//void opponent()
//{
//  if (i%2==1)
//  {  int[] avl = new int[0];
//    for (int a=0; a<=8; a++)
//    {
  
//      if (obj[a]!='O' && obj[a]!='X')
//      {
//        avl = append(avl, a);
//        //avl = append(avl, a);
  
//        //tmp = a;
//        //avl[a] = tmp;
//      }
//    }
//    lf = avl.length;
//    if (avl.length>=1)
//    {
//      rm1 = int(random(avl.length));
  
//      obj[int(avl[rm1])] = pl1[1];
  
//      i++;
//    } else
//    {
//      noLoop();
//      println("THE END");
//    }
//  }
//}

void opponent()
{
  if (i%2==1)
  {  
    int bestscore = -11;
    int move = 0;
    int[] avl = new int[0];
    for (int a=0; a<=8; a++)
    {
  
      if (obj[a]!='O' && obj[a]!='X')
      {
        obj[a] = pl1[1];
        int score = minimax(0, false);
        obj[a] = ' ';
        if (score > bestscore)
        {
          bestscore = score;
          move = a;
        }
      }
    }
    obj[move] = pl1[1];
    i++;
    lt--;
  //  lf = avl.length;
  //  if (avl.length>=1)
  //  {
  //    rm1 = int(random(avl.length));
  
  //    obj[int(avl[rm1])] = pl1[1];
  
  //    i++;
  //  } else
  //  {
  //    noLoop();
  //    println("THE END");
  //  }
  }
}

char checkWinner()
{
  rs = ' ';
  if (lt == 0)
  {
    noLoop();
    rs ='t';
  }
  // first column
  if(obj[0]==obj[1] && obj[1]==obj[2] && obj[0] == obj[2] && obj[0]!=' ')
  {
    noLoop();
    rs =obj[0];
  }
  // second column
  if(obj[3]==obj[4] && obj[4]==obj[5] && obj[3] == obj[5] && obj[3]!=' ')
  {
    noLoop();
    rs =obj[3];
  }
  // third column
  if(obj[6]==obj[7] && obj[7]==obj[8] && obj[6] == obj[8] && obj[6]!=' ')
  {
    noLoop();
    rs =obj[6];
  }
  // first row
  if(obj[0]==obj[3] && obj[3]==obj[6] && obj[0] == obj[6] && obj[0]!=' ')
  {
    noLoop();
    rs =obj[0];
  }
  // second row
  if(obj[1]==obj[4] && obj[4]==obj[7] && obj[1] == obj[7] && obj[1]!=' ')
  {
    noLoop();
    rs =obj[1];
  }
  // third row
  if(obj[2]==obj[5] && obj[5]==obj[8] && obj[2] == obj[8] && obj[2]!=' ')
  {
    noLoop();
    rs =obj[2];
  }
  // right diagonal
  if(obj[0]==obj[4] && obj[4]==obj[8] && obj[0] == obj[8] && obj[0]!=' ')
  {
    noLoop();
    rs =obj[0];
  }
  // left diagonal
  if(obj[2]==obj[4] && obj[4]==obj[6] && obj[2] == obj[6] && obj[2]!=' ')
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
        int score = minimax(depth+1, false);
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
        int score = minimax(depth+1, true);
        obj[a] = ' ';
        bestscore = min(score, bestscore);
      }
    }
    return bestscore;
    
  }




}
