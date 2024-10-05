module top(){

bolts = [[2.4638,-55.5068],[16.8958,-46.9858],[39.1528,-15],[115.1848,-37.5235],[115.1848,-18.4735],[72,-54.754],[25.4343,-62.3667]];

body_top = [[0,-0],[20.7,0],[20.7,2.25],[39.7,2.25],[39.7,4.75],[58.7,4.75],[58.7,7],[76.7,7],[76.7,4.75],[95.7,4.75],[95.7,0],[133.7,0],[133.7,-56.25],[78.2,-56.25],[67.4,-71.15],[29.725,-76],[14.05,-84.875],[0,-60.2]];

button_top = [[1.9+20.7,2.25-1.875],[39.7+1.9,4.75-2],[58.7+1.9,7-1.87],[76.7+2.91,4.75-2],[95.7+2.9,-2],[95.7+21.9,-2]];
    
top_height=6.15;
bolt_r=1.075;
hat_r=2.075;
hat_height=2.05;
wall_height = 2;
wall_width = 0.5;
sphere_height = 3;
f=720;

module spaceForBolt(x,y,top_height,bolt_r){
    translate([x,y,0]) 
    cylinder(h=top_height,r=bolt_r,$fn=720);
}

module spaceForBoltHat(x,y,top_height,hat_height,hat_r){
    translate([x,y,top_height-hat_height]) 
    cylinder(h=hat_height,r=hat_r,center=false,$fn=720);
}


translate([4+10,-4-10,0])
difference(){
    // основная фигура
    linear_extrude(height=top_height) union(){
        minkowski(){
            polygon(points=body_top);
            circle(0.95, $fn=f);
        };
    }
    
    // вырезаем кнопки
    for (k = button_top)
        for (i = [0:1:2]) 
            translate([k[0], k[1]-14-i*19,0]) 
            cube([14,14,top_height]);
        
    translate([12.3476,-77.434,0]) rotate([0,0,30]) 
    cube([14,14,top_height]);
    translate([32.21,-72.695,0]) rotate([0,0,15])
    cube([14,14,top_height]);
    translate([51.1598,-68.3718,0]) cube([14,14,top_height]);
    
    // вырезаем под выступ кнопок
    for (k = button_top)
        for (i = [0:1:2]) 
            translate([k[0]-1, k[1]-15-i*19,0]) 
            cube([16,16,top_height-1.51]);
    
    translate([12.3476,-77.434,0]) rotate([0,0,30]) 
    translate([-1,-1,0]) cube([16,16,top_height-1.51]);
    translate([32.21,-72.695,0]) rotate([0,0,15]) translate([-1,-1,0]) cube([16,16,top_height-1.51]);
    translate([51.1598-1,-68.3718-1,0]) cube([16,16,top_height-1.51]);
    
    // вырезаем место под крышкой
    linear_extrude(height=top_height) minkowski(){
        polygon([[-0.7,0.7],[-0.7,-50.55],[13.15,-50.55],[13.15,-41.6],[15.65,-41.6],[15.65,-34.5],[18.9,-34.5],[18.9,0.7]]);
        square(0.4*2,center=true);
    }
    
    // делаем отверстия под болт
    for (i=bolts) 
        spaceForBolt(i[0],i[1],top_height,bolt_r);
    
    // делаем отверстия под шляпку
    for (i=bolts) 
        spaceForBoltHat(i[0],i[1],top_height,hat_height,hat_r);

    //отверстия под гайку
    translate([2.4638,-55.5068,0]) cylinder(h=2,d=4.5,$fn=6);
    translate([16.8958,-46.9858,0]) cylinder(h=2,d=4.5,$fn=6);
    
    //желоб для крышки
    translate([0,0,top_height-wall_height]) 
    linear_extrude(height=wall_height) difference(){
        minkowski(){
            polygon([[-1,1],[16.8,1],[16.8,-46.7],[1.74,-55.41],
                    [-1,-55.41]]);
            circle(sphere_height,$fn=f);
        }
        minkowski(){
            polygon([[-1,1],[16.8,1],[16.8,-46.7],[1.74,-55.41],
                    [-1,-55.41]]);
            circle(sphere_height-wall_width,$fn=f);
        }
        translate([-4,-70,0]) square([3.05,100]);
        translate([-25,0.95,0]) square([50,3.05]);
    }
}
}
top();