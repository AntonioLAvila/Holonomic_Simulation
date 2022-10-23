public DriveTrain drive;

PVector v = new PVector(50,20);
float rotate = 0;

void setup(){
    size(1920, 1080);
    background(#303134);
    drive = new DriveTrain();
}

void draw(){
    drive.drawDrive();
    drive.updatePos(v, rotate);
    //background(#303134);

}
