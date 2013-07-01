import graph;
import utils;

size(200,150,IgnoreAspect);
scale(Log,Log);

// used to over-ride the normal legend
// usage:
// asy vt -u "runlegs=\"asdf\""

// Use usersetting() to get optional 
string runlegs;
usersetting();
bool myleg=((runlegs == "") ? false: true);
string[] legends=set_legends(runlegs);

string yvar=getstring("y variable: meanjx, meanjy, meanjz, jmax, jxmax, jymax, jzmax");

int ypos=0;
if(yvar == "meanjx") ypos=1;
if(yvar == "meanjy") ypos=2;
if(yvar == "meanjz") ypos=3;
if(yvar == "jmax") ypos=4;
if(yvar == "jxmax") ypos=5;
if(yvar == "jymax") ypos=6;
if(yvar == "jzmax") ypos=7;

string datafile="jvt";


if(ypos == 0) {
  write("Invalid choice for y variable.");
  exit();
}

string runs=getstring("runs");
string run;
int n=-1;
bool flag=true;
int lastpos;
while(flag) {
  ++n;
  int pos=find(runs,",",lastpos);
  if(lastpos == -1) {run=""; flag=false;}
  run=substr(runs,lastpos,pos-lastpos);
  if(flag) {
    write(run);
    lastpos=pos > 0 ? pos+1 : -1;

    // load all of the data for the run:
    string filename, tempstring;
   
    filename=run+"/"+datafile;
    file fin=input(filename).line();
    real[][] a=fin.dimension(0,0);
    a=transpose(a);
    
    // get time:
    real[] t=a[0];
    
    string legend=myleg ? legends[n] : texify(run);
    draw(graph(t,a[ypos],t>0),Pen(n),legend);
  }
}

// Optionally draw different data from files as well:
draw_another(myleg,legends,n);

// Draw axes
yaxis(yvar,LeftRight,LeftTicks);
xaxis("time",BottomTop,LeftTicks);
  
attach(legend(),point(plain.E),20plain.E);


