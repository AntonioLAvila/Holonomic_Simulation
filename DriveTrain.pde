public class DriveTrain{

    public PShape baseShape;
    private float scale = 20;
    
    //0--------1
    //|        |
    //|        |
    //3--------2
    private float[] wheelPowers = new float[]{0,0,0,0};
    private PVector basePos = new PVector(width/2, height/2);
    private final PVector[] wheelPos = new PVector[]{new PVector(-2.5*scale,-2.5*scale), new PVector(2.5*scale,-2.5*scale), new PVector(2.5*scale,2.5*scale), new PVector(-2.5*scale,2.5*scale)};
    private final PVector[] wheelUnitVectors = new PVector[]{new PVector(1/sqrt(2), 1/sqrt(2)), new PVector(-1/sqrt(2), 1/sqrt(2)), new PVector(1/sqrt(2), 1/sqrt(2)), new PVector(-1/sqrt(2), 1/sqrt(2))};
    private PVector[] wheelVectors = new PVector[]{new PVector(0,0), new PVector(0,0), new PVector(0,0), new PVector(0,0)};

    public DriveTrain(){
        populateBaseShape(scale);
    }

    private void populateBaseShape(float scaleFactor){
        baseShape = createShape();
        baseShape.beginShape();
        baseShape.vertex(-2*scaleFactor,-3*scaleFactor);
        baseShape.vertex(-3*scaleFactor,-2*scaleFactor);
        baseShape.vertex(-3*scaleFactor,2*scaleFactor);
        baseShape.vertex(-2*scaleFactor,3*scaleFactor);
        baseShape.vertex(2*scaleFactor,3*scaleFactor);
        baseShape.vertex(3*scaleFactor,2*scaleFactor);
        baseShape.vertex(3*scaleFactor,-2*scaleFactor);
        baseShape.vertex(2*scaleFactor,-3*scaleFactor);
        baseShape.endShape();
    }
    
    //translate is the vector corresponding to controller input
    //rotate is on [-1,1] describes how fast to rotate
    private void updateWheelVectors(PVector translate, float rotate){      
      wheelPowers[0] = rotate + translate.dot(wheelUnitVectors[0]);
      wheelPowers[1] = -rotate + translate.dot(wheelUnitVectors[1]);
      wheelPowers[2] = rotate + translate.dot(wheelUnitVectors[2]);
      wheelPowers[3] = -rotate + translate.dot(wheelUnitVectors[3]);
      
      for(int i = 0; i < wheelVectors.length; i++){
        wheelVectors[i].set(wheelUnitVectors[i].x*wheelPowers[i], wheelUnitVectors[i].y*wheelPowers[i]);
      }
      
      System.out.print(wheelPowers[0]+" ");
      System.out.print(wheelPowers[1]+" ");
      System.out.print(wheelPowers[2]+" ");
      System.out.println(wheelPowers[3]);

    }
    
    private void drawDriveVectors(){
      for(int i = 0; i < wheelPos.length; i++){
        circle(wheelPos[i].x + basePos.x, wheelPos[i].y + basePos.y, 10);
        line(wheelPos[i].x + basePos.x,
             wheelPos[i].y + basePos.y,
             wheelPos[i].x + basePos.x + wheelVectors[i].x,
             wheelPos[i].y + basePos.y - wheelVectors[i].y);
      }     
    }
    
    //experimental
    public void updatePos(PVector translate, float rotate){
      updateWheelVectors(translate, rotate);
    }
    
    public void drawDrive(){
      drawDriveVectors();
      shape(baseShape, basePos.x, basePos.y);
    }
    
    

}
