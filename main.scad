use </home/workspace/case.scad>;
use </home/workspace/top.scad>;
use </home/workspace/cap.scad>;

translate([0,0,0]) case();
translate([0,0,12]) top();
translate([0,0,23.5]) cap();

mirror([1,0,0]) 
translate([0,0,0]) case();
mirror([1,0,0]) 
translate([0,0,12+30]) top();
mirror([1,0,0]) 
translate([0,0,23.5+30+5]) cap();