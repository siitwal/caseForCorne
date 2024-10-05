module cap(){
    
height_top = 5.35;
wall_height = height_top+2;
wall_width = 0.5;
sphere_height = 3;
bolt_r=1.075;
hat_r=2.075;
hat_height=2.05;
f=720;
    
translate([4+10,-4-10,0])
difference(){
    
    union(){
        difference(){
            //основная фигура
            translate([0,0,-sphere_height-wall_height]) minkowski(){
                
                linear_extrude(height=wall_height+0.5) 
                polygon([[-1,1],[16.8,1],[16.8,-46.7],[1.74,-55.41],
                        [-1,-55.41]]);
                
                translate([0,0,3]) sphere(sphere_height,$fn=f);
            }
            
            
            //обрезаем лишнюю часть
            translate([-20,-80,-sphere_height-wall_height]) 
            cube([100,100,sphere_height]);

            translate([0,0,-wall_height]) 
            linear_extrude(height=wall_height) 
            minkowski(){
                polygon([[-1,1],[16.8,1],[16.8,-46.7],[1.74,-55.41],
                        [-1,-55.41]]);
                circle(sphere_height-wall_width,$fn=f);
            }
            
            
            translate([-4,-70,-wall_height]) 
            cube([3.05,100,wall_height]);
            
            translate([-25,0.95,-wall_height]) 
            cube([50,3.05,wall_height]);
        
            
            //делаем желоб
            translate([-2,-55,0]) cube([1,55,1.5]);
            translate([0,1,0]) cube([17,1,1.5]);
            
            rotate([0,0,90]) translate([0,0,0]) 
            rotate_extrude(angle=90, $fn=f) 
            translate([1,0,0]) square([1,1.5]);
        
        }
    
        //добавляем выступ снизу 
        translate([-3,-55,-1.5]) cube([1,55,4]);
        translate([0,2,-1.5]) cube([17,1,4]);
        
        rotate([0,0,90]) translate([0,0,-1.5]) 
        rotate_extrude(angle=90, $fn=f) 
        translate([2,0,0]) square([1,4]);
    
        translate([2.4638,-55.5068,-height_top-2])
        cylinder(h=height_top+3, r=2.3,$fn=f);
        
        translate([16.8958,-46.9858,-height_top-2])
        cylinder(h=height_top+3, r=2.3,$fn=f);
    }
    
    
    //делаем отверстие под болт
    translate([2.4638,-55.5068,0]) 
    cylinder(h=100,r=bolt_r,center=true,$fn=f);
    
    translate([16.8958,-46.9858,0]) 
    cylinder(h=100,r=bolt_r,center=true,$fn=f);
    
    
    //делаем отверстие под головку болта
    translate([2.4638,-55.5068,sphere_height+0.5-hat_height]) 
    cylinder(h=hat_height,r=hat_r,center=false,$fn=f);
    
    translate([16.8958,-46.9858,sphere_height+0.5-hat_height]) 
    cylinder(h=hat_height,r=hat_r,center=false,$fn=f);
    
    
    //окошко
    translate([4+6,-41.45+12.5+8,0]) 
    linear_extrude(height=3.5,scale=1.4)
    minkowski(){
        square([6,19],center=true);
        circle(2,$fn=f);
    }
    translate([4-2.5,-41.45-4.5+7.5,0]) cube([12+5,27+7,1.5]);
}
}

cap();