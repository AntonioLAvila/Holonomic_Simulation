public DriveTrain drive;

PVector v = new PVector(0,100);
float rotate = 0;

void setup(){
    size(1920, 1080);
    background(#303134);
    drive = new DriveTrain();
}

void draw(){
    drive.drawDrive();
    //drive.updatePos(vec, rotate);
    //background(#303134);

}

void mouseClicked(){
  drive.updatePos(v, rotate);
}
