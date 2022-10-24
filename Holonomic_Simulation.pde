import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;

ControlIO control;
ControlDevice XboxController;

public DriveTrain drive;

PVector translate = new PVector(0,0);
float rotate = 0;
float speed = 20;  //speed wrt to realtime

void setup(){
  size(1920, 1080);
  background(#303134);
  drive = new DriveTrain(true);
  
  control = ControlIO.getInstance(this);
  XboxController = control.getMatchedDevice("Xbox_Controller");
  if(XboxController == null){
    println("No such controller exists");
  }
  strokeWeight(5);
  textSize(20);
}

void draw(){
  //processing
  getInput();
  drive.updatePos(translate, rotate);
  //drawing
  background(#303134);
  drive.drawDrive();
}


public void getInput(){
  translate.set(XboxController.getSlider("LEFT_X").getValue() * speed,
                -XboxController.getSlider("LEFT_Y").getValue() * speed);
  rotate = XboxController.getSlider("RIGHT_X").getValue() * speed;
}
