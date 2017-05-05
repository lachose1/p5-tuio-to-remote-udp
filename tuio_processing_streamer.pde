import hypermedia.net.*;
import TUIO.*;
import java.util.*;
import static java.lang.Math.toIntExact;

UDP udp;  // define the UDP object
//UDP udpTUIO;  // define the UDP object
TuioProcessing tuioClient;
//List<TuioCursor> pointsList = new ArrayList<TuioCursor>();
Map<Long, TuioCursor> pointsList = new HashMap<Long, TuioCursor>();

String remoteIP = "127.0.0.1";
int remotePort = 3335;
int tuioPort = 3334;

void setup()
{
  size(1,1);
  //noLoop();
  udp = new UDP( this, 6000 );
  tuioClient = new TuioProcessing(this, tuioPort);
  //udpTUIO = new UDP( this, 3333 );
  //udpTUIO.log( true );
  //udpTUIO.listen( true );
  //initTimer(); //Call to the initialisation of the general timer
}

void draw()
{
  background(0);
  fill(255);
  stroke(255);
  //access via new for-loop
  //for(TuioCursor curTouch : pointsList) {
  //    println(Long.toString(curTouch.getSessionID()) + " " + curTouch.getX() + " " + curTouch.getY() + " 0 0");
  //}
  //udp.send(" 0 0");
  String datagram = "";
  //for(TuioCursor curTouch : pointsList) {
  //    datagram += Long.toString(curTouch.getSessionID()) + " " + curTouch.getX() + " " + curTouch.getY() + " 0 0,";
  //    //udp.send(" 0 0");
  //}
  for(Map.Entry<Long, TuioCursor> entry : pointsList.entrySet()) {
    TuioCursor curTouch = entry.getValue();
    datagram += Long.toString(curTouch.getSessionID()) + " " + curTouch.getX() + " " + curTouch.getY() + " 0 0,";
    // do what you have to do here
    // In your case, an other loop.
  }
  if(pointsList.size() > 0)
    udp.send(datagram, remoteIP, remotePort);
  else
    udp.send("    ", remoteIP, remotePort);
}

// --------------------------------------------------------------
// these callback methods are called whenever a TUIO event occurs
// there are three callbacks for add/set/del events for each object/cursor/blob type
// the final refresh callback marks the end of each TUIO frame

// called when an object is added to the scene
void addTuioObject(TuioObject tobj) {
  //pointsList.add(tobj.getSymbolID(), tobj.getX() + " " + tobj.getY() + " " + tobj.getAngle() + " 0");
  //udp.send(Long.toString(tobj.getSessionID()) + " " + tobj.getX() + " " + tobj.getY() + " " + tobj.getAngle() + " 0", remoteIP, remotePort );
  //println("add obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
}

// called when an object is moved
void updateTuioObject (TuioObject tobj) {
  //udp.send(Long.toString(tobj.getSessionID()) + " " + Long.toString(tobj.getSessionID()) + " " + tobj.getY() + " " + tobj.getAngle() + " 0", remoteIP, remotePort );
  //println("set obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle()
          //+" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());
}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  //println("del obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
}

// --------------------------------------------------------------
// called when a cursor is added to the scene
void addTuioCursor(TuioCursor tcur) {
  //println("add cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY());
  long cursorID = tcur.getSessionID();
  pointsList.put(cursorID, tcur);
  //TuioCursor curTouch = pointsList.get(cursorID);
  //udp.send(Long.toString(curTouch.getSessionID()) + " " + curTouch.getX() + " " + curTouch.getY() + " 0 0", remoteIP, remotePort );
}

// called when a cursor is moved
void updateTuioCursor (TuioCursor tcur) {
  long cursorID = tcur.getSessionID();
  pointsList.put(cursorID, tcur);
  //TuioCursor curTouch = pointsList.get(cursorID);
  //udp.send(Long.toString(curTouch.getSessionID()) + " " + curTouch.getX() + " " + curTouch.getY() + " 0 0", remoteIP, remotePort );
  //println("set cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY()
          //+" "+tcur.getMotionSpeed()+" "+tcur.getMotionAccel());
}

// called when a cursor is removed from the scene
void removeTuioCursor(TuioCursor tcur) {
  long cursorID = tcur.getSessionID();
  pointsList.remove(cursorID);
  //pointsList.remove(cursorID);
  //println("del cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+")");
}

// --------------------------------------------------------------
// called when a blob is added to the scene
void addTuioBlob(TuioBlob tblb) {
  //println("add blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+") "+tblb.getX()+" "+tblb.getY()+" "+tblb.getAngle()+" "+tblb.getWidth()+" "+tblb.getHeight()+" "+tblb.getArea());
}

// called when a blob is moved
void updateTuioBlob (TuioBlob tblb) {
  //println("set blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+") "+tblb.getX()+" "+tblb.getY()+" "+tblb.getAngle()+" "+tblb.getWidth()+" "+tblb.getHeight()+" "+tblb.getArea()
          //+" "+tblb.getMotionSpeed()+" "+tblb.getRotationSpeed()+" "+tblb.getMotionAccel()+" "+tblb.getRotationAccel());
}

// called when a blob is removed from the scene
void removeTuioBlob(TuioBlob tblb) {
  //println("del blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+")");
}

// --------------------------------------------------------------
// called at the end of each TUIO frame
void refresh(TuioTime frameTime) {   
  //println("frame #"+frameTime.getFrameID()+" ("+frameTime.getTotalMilliseconds()+")");
}