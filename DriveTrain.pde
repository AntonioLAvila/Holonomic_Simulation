public class DriveTrain{

  private PShape baseShape;
  private float scale = 20;
  private float fudgeFactor;
  private float rotate;
  
  //0--------1
  //|        |
  //|        |
  //3--------2
  private float[] wheelPowers = new float[]{0,0,0,0};
  private PVector basePos = new PVector(width/2, height/2);
  private final PVector[] wheelPos = new PVector[]{new PVector(-2.5*scale,-2.5*scale), new PVector(2.5*scale,-2.5*scale), new PVector(2.5*scale,2.5*scale), new PVector(-2.5*scale,2.5*scale)};
  private final PVector[] wheelUnitVectors = new PVector[]{new PVector(1/sqrt(2), 1/sqrt(2)), new PVector(-1/sqrt(2), 1/sqrt(2)), new PVector(1/sqrt(2), 1/sqrt(2)), new PVector(-1/sqrt(2), 1/sqrt(2))};
  private PVector[] wheelVectors = new PVector[]{new PVector(0,0), new PVector(0,0), new PVector(0,0), new PVector(0,0)};

  public DriveTrain( boolean fudgeVisuals){
    populateBaseShape();
    if(fudgeVisuals){
      fudgeFactor = 5;
    }else{
      fudgeFactor = 1;
    }
  }

  private void populateBaseShape(){
      baseShape = createShape();
      baseShape.beginShape();
      baseShape.fill(0, 0, 255);
      baseShape.vertex(-2*scale,-3*scale);
      baseShape.vertex(-3*scale,-2*scale);
      baseShape.vertex(-3*scale,2*scale);
      baseShape.vertex(-2*scale,3*scale);
      baseShape.vertex(2*scale,3*scale);
      baseShape.vertex(3*scale,2*scale);
      baseShape.vertex(3*scale,-2*scale);
      baseShape.vertex(2*scale,-3*scale);
      baseShape.endShape(CLOSE);
  }
  
  //translate is the vector corresponding to controller input
  //rotate is on [-1,1] describes how fast to rotate
  private void updateWheelVectors(PVector translate, float rotate){          
    wheelPowers[0] = translate.dot(wheelUnitVectors[0]) + rotate;
    wheelPowers[1] = translate.dot(wheelUnitVectors[1]) - rotate;
    wheelPowers[2] = translate.dot(wheelUnitVectors[2]) - rotate;
    wheelPowers[3] = translate.dot(wheelUnitVectors[3]) + rotate;
    
    this.rotate = rotate;
    
    
    for(int i = 0; i < wheelVectors.length; i++){
      wheelVectors[i].set(wheelUnitVectors[i].x*wheelPowers[i], wheelUnitVectors[i].y*wheelPowers[i]);
    }
  }
  
  float xTot = 0;
  float yTot = 0;
  //experimental
  public void updatePos(PVector translate, float rotate){
    updateWheelVectors(translate, rotate);
    xTot = 0;
    yTot = 0;
    for(int i = 0; i < wheelVectors.length; i++){
      xTot += wheelVectors[i].x;
      yTot += wheelVectors[i].y;
    }
    basePos.set(basePos.x + xTot/4, basePos.y - yTot/4);
  }
  
  public void drawDrive(){
    shape(baseShape, basePos.x, basePos.y);
    
    //drive "wheels" and vectors
    for(int i = 0; i < wheelPos.length; i++){
      circle(wheelPos[i].x + basePos.x, wheelPos[i].y + basePos.y, 5);
      line(wheelPos[i].x + basePos.x,
            wheelPos[i].y + basePos.y,
            wheelPos[i].x + basePos.x + (wheelVectors[i].x * fudgeFactor),
            wheelPos[i].y + basePos.y - (wheelVectors[i].y * fudgeFactor));
    }
    
    //show vectors
    for(int i = 0; i < wheelVectors.length; i++){
      text("Power " + (i+1) + ": " + wheelPowers[i], 10, 30+30*i);
      text("Vector "  + (i+1) + ": <" + wheelVectors[i].x + ", " + wheelVectors[i].y + ">" , 200, 30+30*i);
    }
  }
    
    

}
