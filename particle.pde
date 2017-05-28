class particle{
color[] colors ={ #22433C, #07DEB1, #123EB4, #7012B4, #D917E8, #430928};
float mass =1;
float radius =1;
float charge = 0;
float orbitMag =0;
color pColor = color(#17C1A3);

float colmapper =0;
PVector vec;
PVector pos;
PVector prepos;
PVector acceleration;
PVector force;
float life = 200;
boolean stuck=false;
particle()
{
  pos =new PVector(0,0,0);
  prepos =new PVector(0,0,0);
  vec =new PVector(0,0,0);
  acceleration=new PVector(0,0,0);
}
particle(int posX,int posY)
{
  pos =new PVector(posX,posY,0);
  prepos =new PVector(0,0,0);
  vec =new PVector(0,0,0);
  acceleration=new PVector(0,0,0);
}

void setForce(PVector _f)
{
  force =_f;
}
void applyForce(PVector force) {
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }
  
  void update() {
   if(!stuck){
        vec.add(acceleration);
       vec.normalize().mult(1.7);   
        pos.add(vec);
           
        prepos.set(pos);
        //vec.mult(0.5);
        //vec.limit(1);
        acceleration.mult(0);
        // println("vel:"+ vec.mag());
       // colmapper= vec.mag();println("colmap: "+(colmapper-1)*1000);
        //vec.normalize().mult(1);
        //vec.mult(0.9999);
        life--;
        if(pos.x>width+500 || pos.x<-500 || pos.y>height+500 || pos.y<-500  || life<0)
         rest();
   }else{
   
     //mass =500*noise(acceleration.x,acceleration.y);
   }
 }

void draw()
{
 
  noStroke();
  if(!stuck){
//  fill(pColor);
//  colorMode(HSB,100);
  int val=(int)(255*noise(mass,pos.x,pos.y));
  //println(pixels[mouseColselector]);

    fill(#C93600);//pixels[val]);best color effect till now t#551EB7
   // rect(0,0,30,30);
    //stroke(map(colmapper,0,5,0,100),99,99);
    //tint(#551EB7);
    //image(pacimg,pos.x,pos.y);
    ellipse(pos.x,pos.y,radius,radius);
    //line(prepos.x,prepos.y,pos.x,pos.y);
    noStroke();
   colorMode(RGB,255);   
  }else{
if(orbitMag>0)
  fill(150,0,0);
  else
  fill(0,150,0);
  //ellipse(pos.x,pos.y,radius,radius);
  }
}
void rest()
{
  vec.mult(0);
  life=random(200,300);
  if(stuck){
    pos.x =random(0+100,width-100);
    pos.y =random(0+100,height-100);
  }//else
  //{
  // if(random(0,4)<2){
  //      if(random(0,4)<2){
  //          pos.x =random(-10,0);
  //          pos.y =random(0,height);
  //      }else
  //      {
  //        pos.x =random(width,width+10);
  //        pos.y =random(0,height);
  //      }
  // }else{
  //      if(random(0,4)<2){
  //          pos.y =random(-10,0);
  //          pos.x =random(0,width);
  //      }else
  //      {
  //        pos.y =random(height,height+10);
  //        pos.x =random(0,width);
  //      }   
  // }
  //}
  {
      pos.x =random(0,width);
    pos.y =random(0,height);
  }
}
void particleInfo()
{
  stroke(255);
  if(stuck)
  text(mass ,pos.x + 3 , pos.y+3);
}
}