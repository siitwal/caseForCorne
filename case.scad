module case(){

body_height=2.5;
helper_height=body_height+8;
border_height=helper_height+13;
space=1;
border_weight=3;
bolt_r=1.075;
f=100;

leg_position=[[5,-5],[127.7,-5],[127.7,-50.25],[5,-50.25],[15,-80],
              [66,-68],[68,4.5]];
sokets=[[20.9,-9.46],[39.9,-7.06],[58.9,-4.66],[77.9,-7.06],
        [96.9,-12],[115.9,-12]];
helper2=[[[67.0321,-71.15],[1.5,78.15]],[[114.44,-56.25],
        [1.5,56.25]],[[115.19,-19.5],[18.51,1.5]],[[24.7,-81.55,0],[1.5,19]]];
bolts=[[39.1528,-15,1.5],[115.1848,-37.5235,1.5],
        [115.1848,-18.4735,1.5],[72,-54.754,1.5],
        [25.4343,-62.3667,1.5]];
boxes=[[[115.19,-18.75,0],[10,10]],[[115.19,-37.5,0],[10,10]],
        [[39.29,-15,0],[6,13]],[[25.45,-62.55,0],[10,10.5]],
        [[72.05,-54.8,0],[10,10]],[[67.7821,-9.5,0],[10,8]]];
value = [[0,-0],[20.7,0],[20.7,2.25],[39.7,2.25],[39.7,4.75],
        [58.7,4.75],[58.7,7],[76.7,7],[76.7,4.75],[95.7,4.75],
        [95.7,0],[133.7,0],[133.7,-56.25],[78.2,-56.25],
        [67.4,-71.15],[29.725,-76],[14.05,-84.875],[0,-60.2]];
value2 = [[0,-0],[20.7,0],[20.7,2.25],[39.7,2.25],[39.7,4.75],
         [58.7,4.75],[58.7,7],[76.7,7],[76.7,4.75],[95.7,4.75],
         [95.7,0],[133.7,0],[133.7,-51.25],[78.2,-51.25],
         [67.4,-66.15],[29.725,-71],[14.05,-79.875],[0,-55.2]];

module leg(pos){
    translate([pos[0],pos[1],-1]) difference(){
        linear_extrude(height=2,scale=1.4) 
        circle(4.5,$fn=100);
        
        cylinder(h=2,r=4,$fn=100);
    }
}

translate([4+10,-4-10,0])
difference(){
    union(){
        linear_extrude(height=body_height) polygon(points=value);
        linear_extrude(height=helper_height) union(){
            // space
            difference(){
                minkowski(){
                    polygon(points=value);
                    circle(1, $fn=f);
                };
                polygon(points=value);
            }
            // упоры под плату по кромке
            difference(){
                polygon(points=value);
                translate([0,-1,0]) 
                polygon(points=value2);
            }
            //отдел для батареи
            polygon(points=[[0,0],[0,-57.5],[1,-57.5],[1,0]]);
            polygon(points=[[0,-56.3],[38.5,-56.3],[38.5,-57.5],[0,-57.5]]);
            polygon(points=[[38.5,-57.5-20],[39.7,-57.5-20],[39.7,2.25],[38.5,2.25]]);
            
            //средняя линия упор под плату
            polygon(points=[[133.7,-33.9],[39.7,-33.9],[39.7,-31],[133.7,-31]]);
            
            //центральные вертикальные линии упоры под плату
            polygon(points=[[75.7-19,6.75],[78.2-19,6.75],[78.2-19,-56.25-13],[75.7-19,-56.25-13]]);
            polygon(points=[[75.7,6.75],[78.2,6.75],[78.2,-56.25],[75.7,-56.25]]);
            polygon(points=[[75.7+19,6.75],[78.2+19,6.75],[78.2+19,-56.25],[75.7+19,-56.25]]);
            
            // пара правых упоров
            polygon(points=[[133.7,-13.3],[133.7,-19.7],[128.7,-19.7],[128.7,-13.3]]);
            polygon(points=[[133.7,-32.75],[133.7,-38.9],[128.7,-38.9],[128.7,-32.75]]);
            
            //прямоугольные упоры
            for(box=boxes) translate(box[0]) square(box[1],center=true);
            //второстепенные линии
            for(line=helper2) translate(line[0]) square(line[1],false);
        }
        linear_extrude(height=border_height) difference(){
            minkowski(){
                minkowski(){
                    polygon(points=value);
                    square(space*2, center=true);
                };
                circle(border_weight, $fn=f);
            };
            minkowski(){
                polygon(points=value);
                circle(space, $fn=f);
            };
        }
        translate([-2,-55,border_height-1]) cube([1,55,2.5]);
        translate([0,1,border_height-1]) cube([17,1,2.5]);
        
        rotate([0,0,90]) translate([0,0,border_height-1])
        rotate_extrude(angle=90, $fn=f) 
        translate([1,0,0]) square([1,2.5]);
        
        // рисуем ножки
        for (i=leg_position) leg(i);
    }
    
    
    // вырезаем под бортик крышки
    translate([-3,-55,border_height-1.5]) cube([1,55,1.5]);
    translate([0,2,border_height-1.5]) cube([17,1,1.5]);
    rotate([0,0,90]) translate([0,0,border_height-1.5]) rotate_extrude(angle=90, $fn=f) translate([2,0,0]) square([1,1.5]);
    
    
    // вырезаем под ttrs
    translate([-space,-51+2,2+helper_height]) rotate([0,-90,0]) 
    linear_extrude(height = border_weight) minkowski() { 
        square([9-4, 9-4]);
        circle(2,$fn=f);
    }
    
    // вырезаем под type c
    translate([5.125,space+3,2+helper_height+2.8]) rotate([90,0,0]) 
    linear_extrude(height = border_weight) minkowski() { 
        square([14-4,8-4]);
        circle(2,$fn=f);
    }
    
    // вырезаем под болты
    for(i=bolts) 
        translate(i) cylinder(9, r=bolt_r, center=false, $fn=f);
    
    // вырезаем под гайки
    translate([22.95,-64.55,4.5]) cube([7.5,4.1,2]);
    translate([67,-56.8,4.5]) cube([7.55,4.1,2]);
    translate([110.14,-20.75,4.5]) cube([7.55,4.1,2]);
    translate([110.14,-39.5,4.5]) cube([7.55,4.1,2]);
    translate([36.79,-17,4.5]) cube([5.55,4.1,2]);
    
    // вырезаем под сокеты
    for (k=[0:1:5]){
        for (i=[0:1:2]){
            translate([sokets[k][0]-0.75,sokets[k][1]-0.5-i*19,helper_height-2.15]) 
            cube([16.9+1.5,9.55+1,2.15]);
        }
    }
    translate([11.45,-60.2,helper_height-2.15]) 
    rotate([0,0,-60]) translate([-0.5,-0.5,0]) cube([16.25+1,6+1,2.15]);
    translate([28.45,-66.1,helper_height-2.15]) 
    rotate([0,0,15]) translate([-0.5,-0.5,0]) cube([16.25+1,6+1,2.15]);
    translate([49.4-0.5,-61-0.5,helper_height-2.15]) cube([16.25+1,6+1,2.15]);
    
    translate([44.1-0.5,-64.57-0.5,helper_height-1.5]) cube([4.35+1,5.4+1,1.5]);
    translate([46.18-0.5,-64.69-0.5,helper_height-1.5]) cube([4.35+1,5.4+1,1.5]);

    translate([65-0.5,-64.56-0.5,helper_height-1.5]) cube([1.5+1,5.4+1,1.5]);
    translate([68.03-0.5,-64.7-0.5,helper_height-1.5]) cube([1.5+1,5.4+1,1.5]);
    
    // текст снизу
    translate([116,-15,0]) linear_extrude(height=0.5)
    mirror([1,0,0]) text("SIITWAL",font="Neuropol",size=15);
    translate([82,-55,0]) linear_extrude(height=0.5)
    mirror([1,0,0]) text("",font="FiraCode Nerd Font Mono",size=40);
    translate([2,-7,2]) linear_extrude(height=0.5)
    rotate([0,0,-90]) text("BATTERY",font="Neuropol",size=5);
}
}

case();