import geomerative.*; 
PImage img;
PImage pacimg;
RFont f;
RShape grp;
RPoint[] points;
int mouseColselector=0;
boolean stop =false;
boolean recording =false;
ParticleSystem ps;
void setup()
{
  size(1000,700);
  smooth(8);
  pixelDensity(2);
  img =loadImage("pixpal.png");
  pacimg =loadImage("particle.png");
  imageMode(CENTER);
   image(img,0,0);
   loadPixels();
  //translate(width/2,height/2);
   RG.init(this);
   grp = RG.getText("Shirish", "FreeSans.ttf", 350, CENTER);
  
  
  ps=new ParticleSystem(5000);
  RG.setPolygonizer(RG.UNIFORMLENGTH);
  RG.setPolygonizerLength(27);
  points = grp.getPoints();
  
        if(points!=null)
        {
        for(int i=0;i<points.length;i++)
        {
          //println("posX: "+points[i].x);
          ps.addGravitor(width/2+(int)points[i].x,height/2+200 +(int)points[i].y);
        }
      
        }
  
    background(0);
    blendMode(ADD);
}
void draw()
{
//  mouseColselector =(int) map(mouseX,0,width,0,255);
  if(stop){
   //blendMode(BLEND);
  fill(0,1);rect(0,0,width,height);
   blendMode(ADD);
 // if(random(0,9)<0.9)
    {
    //  blendMode(BLEND);
      fill(0,1);rect(0,0,width,height);rect(0,0,width,height);
    }
  ps.update();
   ps.draw();
  if(recording && stop)
   saveFrame("output/frames-######.png");
   //println("drawing");
  }
  //stroke(255);
  
  //grp.draw();
}
void keyPressed()
{
  if(key == ' ')
  {
    stop = !stop;
    if(stop)
    {
    background(0);
    loop();
    }
  }else if(key == 'R' || key=='r')
  {
    recording= !recording;
  }
blendMode(BLEND);
image(img,0,0);
}
void mousePressed()
{
    ps.addGravitor(mouseX,mouseY);
    fill(0,255,0);
    ellipse(mouseX,mouseY,1,1);  
}