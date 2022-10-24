public class DriveTrain{

  private PShape baseShape;
  private float scale = 20;
  private boolean debug = false;
  
  //0--------1
  //|        |
  //|        |
  //3--------2
  private float[] wheelPowers = new float[]{0,0,0,0};
  private final PVector[] wheelPos = new PVector[]{new PVector(-2.5*scale + width/2, -2.5*scale + height/2), new PVector(2.5*scale + width/2, -2.5*scale + height/2), new PVector(2.5*scale + width/2, 2.5*scale + height/2), new PVector(-2.5*scale + width/2, 2.5*scale + height/2)};
  private final PVector[] wheelUnitVectors = new PVector[]{new PVector(1/sqrt(2), 1/sqrt(2)), new PVector(-1/sqrt(2), 1/sqrt(2)), new PVector(1/sqrt(2), 1/sqrt(2)), new PVector(-1/sqrt(2), 1/sqrt(2))};
  private PVector[] wheelVectors = new PVector[]{new PVector(0,0), new PVector(0,0), new PVector(0,0), new PVector(0,0)};

  public DriveTrain(){
    populateBaseShape();
  }

  //base this on wheelPos[]
  private void populateBaseShape(){
      baseShape = createShape();
      baseShape.beginShape();
      baseShape.fill(0, 0, 255);
      baseShape.vertex(wheelPos[0].x - 0.5*scale, wheelPos[0].y + 0.5*scale);
      baseShape.vertex(wheelPos[0].x + 0.5*scale, wheelPos[0].y - 0.5*scale);
      
      baseShape.vertex(wheelPos[1].x - 0.5*scale, wheelPos[1].y - 0.5*scale);
      baseShape.vertex(wheelPos[1].x + 0.5*scale, wheelPos[1].y + 0.5*scale);
      
      baseShape.vertex(wheelPos[2].x + 0.5*scale, wheelPos[2].y - 0.5*scale);
      baseShape.vertex(wheelPos[2].x - 0.5*scale, wheelPos[2].y + 0.5*scale);
      
      baseShape.vertex(wheelPos[3].x + 0.5*scale, wheelPos[3].y + 0.5*scale);
      baseShape.vertex(wheelPos[3].x - 0.5*scale, wheelPos[3].y - 0.5*scale);
      baseShape.endShape(CLOSE);
  }
  
  //translate is the vector corresponding to controller input
  //rotate is on [-1,1] describes how fast to rotate
  private void updateWheelVectors(PVector translate, float rotate){      
    wheelPowers[0] = translate.dot(wheelUnitVectors[0]);
    wheelPowers[1] = translate.dot(wheelUnitVectors[1]);
    wheelPowers[2] = translate.dot(wheelUnitVectors[2]);
    wheelPowers[3] = translate.dot(wheelUnitVectors[3]);
    
    for(int i = 0; i < wheelVectors.length; i++){
      wheelVectors[i].set(wheelUnitVectors[i].x*wheelPowers[i], wheelUnitVectors[i].y*wheelPowers[i]);
    }
    
    if(debug){
      System.out.print(wheelPowers[0]+" ");
      System.out.print(wheelPowers[1]+" ");
      System.out.print(wheelPowers[2]+" ");
      System.out.println(wheelPowers[3]);
    }

  }
  
  float xTot = 0;
  float yTot = 0;
  public void updatePos(PVector translate, float rotate){
    updateWheelVectors(translate, rotate);
    for(int i = 0; i < wheelPos.length; i++){
      wheelPos[i].set(wheelPos[i].x + wheelVectors[i].x, wheelPos[i].y - wheelVectors[i].y);
    }
  }
  
  public void drawDrive(){
    populateBaseShape();
    shape(baseShape, (wheelPos[0].x + wheelPos[1].x)/2, (wheelPos[0].y + wheelPos[3].y)/2);
    //drive "wheels" and vectors
    for(int i = 0; i < wheelPos.length; i++){
      circle(wheelPos[i].x, wheelPos[i].y, 5);
      line(wheelPos[i].x,
            wheelPos[i].y,
            wheelPos[i].x + (wheelVectors[i].x * 5),
            wheelPos[i].y - (wheelVectors[i].y * 5));
    }
    
    //show vectors
    for(int i = 0; i < wheelVectors.length; i++){
      text("Wheel " + (i+1) + "| Power: " + wheelPowers[i] + " Vector: <" + wheelVectors[i].x + ", " + wheelVectors[i].y + ">" , 10, 30+30*i);
    }
  }
    
    

}
