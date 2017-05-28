class ParticleSystem{
float numParticles=0;
ArrayList<particle> particles= new ArrayList();
ParticleSystem(float _np)
{
  numParticles=_np;
  particle p;
  for(int i=0;i<numParticles;i++)
  {
    p = new particle();
    //if(false)//random(0,9)<1)
    //{
    //  p.charge =0;
    //  p.stuck=true;
    //  p.mass =random(10,100);
    //  p.orbitMag =random(-550,550);
    //}else{
      p.charge =1.000001;
      p.mass = 1.7000003;
      p.stuck=false;
      //p.mass=(random(3,10));
    //}
    p.rest();
    particles.add(p);
  }
}

PVector gravityForce(particle p, particle q)
{
    float g= 2.0;
    PVector force = PVector.sub(q.pos,p.pos);             // Calculate direction of force
    float distance = force.mag();                                 // Distance between objects
    distance = constrain(distance,0.001,660.0);                             // Limiting the distance to eliminate "extreme" results for very close or very far objects
    force.normalize();                                            // Normalize vector (distance doesn't matter here, we just want this vector for direction)
    float strength = (g * p.mass * q.mass) / (distance * distance ); // Calculate gravitional force magnitude
    force.mult(strength);                                         // Get force vector --> magnitude * direction
    return force;
}
PVector orbitalForce(particle p, particle q)
{
    float R=q.orbitMag;
    PVector force = PVector.sub(p.pos,q.pos);//correct sequence             // Calculate direction of force
    float distance = force.mag();                // Distance between objects
    //if(distance<600)
    {
    distance = constrain(distance,1,1600.0);                             // Limiting the distance to eliminate "extreme" results for very close or very far objects
    force.normalize();                                            // Normalize vector (distance doesn't matter here, we just want this vector for direction)
    float strength = (R) / ( distance*distance); // Calculate gravitional force magnitude
   PVector f;
   //if(R<=0)
   // f =force.cross(new PVector(0,0,1));
   // else
    f =force.cross(new PVector(0,0,-1));
     
   // println("force: "+force+" f: "+f+" str: "+strength);
    f.mult(strength);
    return f;
    }// Get force vector --> magnitude * direction
    //else{
    //force.mult(0);
    //return force;
    //}
    
}
PVector chargeForce(particle p, particle q)
{
    float u=10;
    PVector force = PVector.sub(p.pos,q.pos);             // Calculate direction of force
    float distance = force.mag();                                 // Distance between objects
    distance = constrain(distance,0.1,50000.0);                             // Limiting the distance to eliminate "extreme" results for very close or very far objects
    force.normalize();                                            // Normalize vector (distance doesn't matter here, we just want this vector for direction)
    float strength = (u * p.charge * q.charge) / (distance * distance); // Calculate gravitional force magnitude
    force.mult(strength);                                         // Get force vector --> magnitude * direction
    return force;
 
}
int stucked=0;
void update()
{
  for(int i=0;i<numParticles;i++)
  {
   particle cp;
    cp=particles.get(i);
    for(int j=0;j<numParticles;j++){
      particle _ocp;
      _ocp = particles.get(j);
      if(cp!=_ocp)
      {
        cp.applyForce(gravityForce(cp,_ocp));
        cp.applyForce(chargeForce(cp,_ocp));
       //if(_ocp.orbitMag!=0)
        cp.applyForce(orbitalForce(cp,_ocp));
      }

    }
  }
  for(int i=0;i<numParticles;i++)
  {
   particle cp;
   cp=particles.get(i);
   cp.update(); 
 //  if(cp.stuck) //for debugging only
    // stucked++;//for debugging only
  }
  //println(stucked);
 // stucked=0;//debugging purpose only
}
void draw()
{
  for(int i=0;i<numParticles;i++)
  {
   particle cp;
   cp=particles.get(i);
   cp.draw(); 
   //cp.particleInfo();//debugging
  }
}
void addGravitor(int x,int y)
{
  particle p= new particle(x,y); 
  p.charge =0;
      p.stuck=true;
      p.mass =random(100,400);
if(random(0,8)<5)
      p.orbitMag =random(1600,5000);
 else
     p.orbitMag=random(-5000,-1600);
      //println("new Gravitor");
  particles.add(p);
  numParticles++;
}
}