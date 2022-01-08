// get result with xclip -selection clipboard -i  < /tmp/positions.txt

import java.util.Collections;
float angle = 0;
PrintWriter output ;
vertex[] vertex;
int index = 0;
ArrayList verts = new ArrayList();
    PShape s;
PShape star;
final int anglelimit = 180;
final int xamigaoffset = 127;
final int yamigaoffset = -32;

final int xamigaoffset2 = 127;
final int yamigaoffset2 = 103;

final int angleincrement = 4;

void setup() {
  size(320, 256, P3D);
  vertex = new vertex[4];
  //noLoop();
  output = createWriter("/tmp/positions.txt");
    int rectwidth=16;

  s = createShape();
  s.beginShape();
   s.fill(0);
  s.stroke(0);
  s.strokeWeight(2);
  
  int space = -7;
  s.vertex(space-rectwidth, -1);
  s.vertex(space, -1);
  s.vertex(space-rectwidth, 1);
  s.vertex(space, 1);
  
  s.endShape(CLOSE);
  
  // First create the shape
  star = createShape();
  star.beginShape();
  // You can set fill and stroke
  star.fill(102);
  star.stroke(0);
  star.strokeWeight(2);
  // Here, we are hardcoding a series of vertices
  star.vertex(0, -50);
  star.vertex(14, -20);
  star.vertex(47, -15);
  star.vertex(23, 7);
  star.vertex(29, 40);
  star.vertex(0, 25);
  star.vertex(-29, 40);
  star.vertex(-23, 7);
  star.vertex(-47, -15);
  star.vertex(-14, -20);
  star.endShape(CLOSE);
}

void stop()
{
    output.close();
}


int frameparity=0;
void draw() {
  int reminder = frameparity%2;
  background(255);
  stroke (0);
  //pushMatrix();
  translate(width/2, height/2, 0);
  rotate(radians(angle));
  
  
  if (reminder==0) drawRectangle();
  pushMatrix();
  rotate(radians(180));
  if (reminder!=0) drawRectangle2();
  popMatrix();
  saveFrame(); 
  if (reminder!=0)
  {
  
    angle+=angleincrement;
    println((int)angle+"------"+anglelimit);
    if ((int)angle>=anglelimit) //<>//
    {
      my_println("step_end:");
        output.close();
        exit();
    }
  }
  frameparity++;
}
void drawRectangle()
{
  println("executing drawrectangle with angle "+(int)angle);
  //point (0,0);

  //shape(star);
  shape(s);
  verts.clear();
  for (int i = 0,index = 0; i < s.getVertexCount(); i++) 
  {
    PVector v = s.getVertex(i);
    vertex newvertex = new vertex(v);
    vertex[index++] = newvertex;
    verts.add(newvertex);
    
  }
  
  Collections.sort(verts);
  int minX = 319;
  for (int i = 0 ; i<verts.size();i++)
  {
    println(verts.get(i).toString());
    vertex curvertex = (vertex)verts.get(i);
    if (curvertex.getModelX()<minX) minX = curvertex.getModelX();
  }
  vertex first = (vertex)verts.get(0);
  vertex last = (vertex)verts.get(3);
  println("First: "+first.toString()+" first y:"+first.getModelY()+" first x"+first.getModelX());
  println("Last: "+last.toString());
  loadPixels();
  
  // Position of the sprite
  byte verticalspritepos = (byte)first.getModelY();
  byte horizontalspritepos = (byte)(minX/2);
  byte horizontalspriteposreminder = (byte)(minX%2);
  byte verticalspriteend = (byte)(1+last.getModelY());
  int spritesize = (1+last.getModelY()-first.getModelY())*4+8;
  spritesize*=2;
  spritesize-=4;
  
  my_println("step_"+(int)angle+":");
  my_println("  dc.w "+spritesize);
  my_print("  dc.b $");
  my_println(hex(verticalspritepos+yamigaoffset,2));
  my_print("  dc.b $");
  my_println(hex(horizontalspritepos+xamigaoffset,2));
  my_print("  dc.b $");
  my_println(hex(verticalspriteend+yamigaoffset,2));
  my_print("  dc.b $");
  my_println(hex(horizontalspriteposreminder));

  // for each row
  int contvertical = 0;
  for (int j=first.getModelY();j<=last.getModelY();j++)
  {
    byte byte1=0;
    byte byte2=0;
    for (int i=0;i<16;i++)
    {
      color c = get(minX+i,contvertical+first.getModelY());
      //println(c);
      if (c!=-1)
      {
        if (i<8)
        {
          byte1 |=  1<<8-i-1;
          //println("byte1 vale "+hex(byte1));
        }
        else
        {
          byte2 |=  1<<8-(i-8)-1;
          //println("byte2 vale "+hex(byte2));
        }
      }
    
    }
    my_print("  dc.w $");
    my_print(hex(byte1));
    my_print(hex(byte2));
    my_print(",$0");
    my_println("");
    contvertical++;
  }
  //my_println("  dc.w                0,0");
  System.out.println("----------------------------------------\n");
  stroke(255,0,0);
  //resetMatrix();
  //popMatrix();
  //line (minX,0,minX,255);
  //line (first.getModelX(),0,first.getModelX(),255);
  //line (0,first.getModelY(),319,first.getModelY());
  //stroke(0,255,0);
   // line (last.getModelX(),0,last.getModelX(),255);
  //line (0,last.getModelY(),319,last.getModelY());
  delay(500);
}

void drawRectangle2()
{
    println("executing drawrectangle2 with angle "+(int)angle);

  shape(s);
  verts.clear();
  for (int i = 0,index = 0; i < s.getVertexCount(); i++) 
  {
    PVector v = s.getVertex(i);
    vertex newvertex = new vertex(v);
    vertex[index++] = newvertex;
    verts.add(newvertex);
    
  }
  
  
  Collections.sort(verts);
  int minX = 319;
  for (int i = 0 ; i<verts.size();i++)
  {
    println(verts.get(i).toString());
    vertex curvertex = (vertex)verts.get(i);
    if (curvertex.getModelX()<minX) minX = curvertex.getModelX();
  }
  vertex first = (vertex)verts.get(0);
  vertex last = (vertex)verts.get(3);
  println("First: "+first.toString()+" first y:"+first.getModelY()+" first x"+first.getModelX());
  println("Last: "+last.toString());
  loadPixels();
  
  // Position of the sprite
  byte verticalspritepos = (byte)first.getModelY();
  byte horizontalspritepos = (byte)(minX/2);
  byte horizontalspriteposreminder = (byte)(minX%2);
  byte verticalspriteend = (byte)(1+last.getModelY());
  int spritesize = (1+last.getModelY()-first.getModelY())*4+8;
  
  my_println("stepsecond_"+(int)angle+":");
  //my_println("  dc.w "+spritesize);
  my_print("  dc.b $");
  my_println(hex(verticalspritepos+yamigaoffset2,2));
  my_print("  dc.b $");
  my_println(hex(horizontalspritepos+xamigaoffset2,2));
  my_print("  dc.b $");
  my_println(hex(verticalspriteend+yamigaoffset2,2));
  my_print("  dc.b $");
  my_println(hex(horizontalspriteposreminder));

  // for each row
  int contvertical = 0;
  for (int j=first.getModelY();j<=last.getModelY();j++) //<>//
  {
    byte byte1=0;
    byte byte2=0;
    for (int i=0;i<16;i++)
    {
      color c = get(minX+i,contvertical+first.getModelY());
      //println(c);
      if (c!=-1)
      {
        if (i<8)
        {
          byte1 |=  1<<8-i-1;
          //println("byte1 vale "+hex(byte1));
        }
        else
        {
          byte2 |=  1<<8-(i-8)-1;
          //println("byte2 vale "+hex(byte2));
        }
      }
    
    }
    my_print("  dc.w $");
    my_print(hex(byte1));
    my_print(hex(byte2));
    my_print(",$0");
    my_println("");
    contvertical++;
  }
  my_println("  dc.w                0,0");
  System.out.println("----------------------------------------\n");

  delay(500);
}

void my_print(String str)
{
   print(str);
   output.print(str);
}

void my_println(String str)
{
   println(str);
   output.println(str);
}

public class vertex implements Comparable<rectangle.vertex>
{
  private PVector vector;
  
  private float screenx_value;
  private float screeny_value;
  
  private float modelx_value;
  private float modely_value;
  private float modelz_value;
  
  vertex (PVector vector)
  {
     this.vector = vector;
     this.screenx_value = screenX(vector.x, vector.y, vector.z);
     this.screeny_value = screenY(vector.x, vector.y, vector.z);
     this.modelx_value = modelX(vector.x, vector.y, vector.z);
     this.modely_value = modelY(vector.x, vector.y, vector.z);
     this.modelz_value = modelZ(vector.x, vector.y, vector.z);

  }
  public int getModelY()
  {
     return (int)Math.round(this.modely_value);
  }
  public int getModelX()
  {
     return (int)Math.round(this.modelx_value);
  }
  public String toString()
  {
    return "X:"+this.vector.x+ " Y:"+this.vector.y+ " Z:"+this.vector.z+" ModelX:"+this.modelx_value+" ModelY:"+this.modely_value+" ModelZ:"+this.modelz_value+" Xscreen:"+this.screenx_value+" Yscreen:"+this.screeny_value;
  }
 public boolean custom_equal(vertex vin)
 {
   //if (vin.vector.x == this.vector.x && vin.vector.y == this.vector.y && vin.vector.z == this.vector.z) return true;
   if (vin.modelx_value == this.modelx_value && vin.modely_value == this.modely_value && vin.modelz_value == this.modelz_value ) return true;
   return false;
 }
 
 @Override
 public int compareTo(vertex v1)
 {
   
   if (this.modely_value == v1.modely_value)
   {
      if (this.modelx_value == v1.modelx_value) return 0;
      if (this.modelx_value > v1.modelx_value) return 1;
      return -1;
   }
   
   if (this.modely_value > v1.modely_value) return 1;
   else return -1;
 }
  
}
