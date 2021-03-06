// Languages: name (local), name_en, name_fr, name_es, name_de
@name: '[name_en]';
@makiIcon: 'maki/[maki]' + '-12.svg';

// Common Colors //
@water: #CCE8FC;
@park: #e3ead6;
@building: #d5cec6;
@main: #f4f4f4;

Map {
  background-color:@main;
}


// Political boundaries //

#admin {
  line-join: round;
  line-color: #333;
  line-opacity: 0.25;
  [maritime=1] { line-color: darken(@water, 3%); }
  // Countries
  [admin_level=2] {
    line-width: 1;
    [zoom>=6] { line-width: 1; }
    [zoom>=8] { line-width: 4; }
    [disputed=1] { line-dasharray: 4,4; }
  }
  // States / Provices / Subregions
  [admin_level>=3] {
    line-width: 0.4;
    line-dasharray: 10,3,3,3;
    [zoom>=6] { line-width: 1; }
    [zoom>=8] { line-width: 2; }
    [zoom>=12] { line-width: 3; }
  }
}


// Places //

#country_label[zoom>=3] {
  text-name: @name;
  text-face-name: 'Source Sans Pro Bold';
  text-wrap-width: 100;
  text-wrap-before: true;
  text-fill: #333;
  text-size: 18;
  text-transform: uppercase;
  text-halo-fill: fadeout(@main, 50%);
  text-halo-radius: 2px;
  [zoom>=3][scalerank=1],
  [zoom>=4][scalerank=2],
  [zoom>=5][scalerank=3],
  [zoom>=6][scalerank>3] {
    text-size: 18;
  }
  [zoom>=4][scalerank=1],
  [zoom>=5][scalerank=2],
  [zoom>=6][scalerank=3],
  [zoom>=7][scalerank>3] {
    text-size: 20;
  }
}

#country_label_line {
  line-color: #324;
  line-opacity: 0.05;
}

#place_label {
  [type='city'][zoom<=15] {
    text-name: @name;
    text-face-name: 'Source Sans Pro Semibold';
    text-fill: #444;
    text-size: 18;
    text-wrap-width: 100;
    text-wrap-before: true;
    text-halo-fill: fadeout(@main, 30%);
    text-halo-radius: 3px;
    [zoom>=10] { text-size: 18; }
    [zoom>=12] { text-size: 24; }
    [zoom <=6] {
    	text-opacity: 0.5;
  	}
  }
  [type='town'][zoom<=17] {
    text-name: @name;
    text-face-name: 'Source Sans Pro Regular';
    text-fill: #444;
    text-size: 14;
    text-wrap-width: 100;
    text-wrap-before: true;
    text-halo-fill: fadeout(@main, 30%);
    text-halo-radius: 2px;
    [zoom>=10] { text-size: 16; }
    [zoom>=12] { text-size: 24; }
  }
  [type='village'] {
    text-name: @name;
    text-face-name: 'Source Sans Pro Regular';
    text-fill: #444;
    text-size: 14;
    text-wrap-width: 100;
    text-wrap-before: true;
    text-halo-fill: fadeout(@main, 30%);
    text-halo-radius: 2px;
    [zoom>=12] { text-size: 14; }
    [zoom>=14] { text-size: 22; }
  }
  [type='hamlet'],
  [type='suburb'],
  [type='neighbourhood'] {
    text-name: @name;
    text-face-name: 'Source Sans Pro Regular';
    text-fill: #444;
    text-size: 14;
    text-wrap-width: 100;
    text-wrap-before: true;
    text-halo-fill: fadeout(@main, 30%);
    text-halo-radius: 2px;
    [zoom>=14] { text-size: 14; }
    [zoom>=16] { text-size: 18; }
  }
}


// Water Features //

#water {
  [zoom >= 16] {
    ::edge {
      polygon-fill: #9fb1be;
      polygon-geometry-transform: translate(-1,-1);
    }
    ::highlight {
      polygon-fill: #d8efff;
      polygon-geometry-transform: translate(2,2);
    }
  }
  polygon-fill: @water; 
  polygon-pattern-file: url(waterTexture.png);
  polygon-pattern-comp-op: multiply;
  polygon-pattern-opacity: .1;
}

#water_label {
  [zoom<=13],  // automatic area filtering @ low zooms
  [zoom>=14][area>500000],
  [zoom>=16][area>10000],
  [zoom>=17] {
    text-name: @name;
    text-face-name: 'Source Sans Pro Italic';
    text-fill: #333;
    text-size: 15;
    text-wrap-width: 100;
    text-comp-op: multiply;
    text-opacity: 0.4;
    text-wrap-before: true;
  }
}

#waterway {
  [type='river'],
  [type='canal'] {
    line-color: @water;
    line-width: 0.5;
    [zoom>=12] { line-width: 1; }
    [zoom>=14] { line-width: 2; }
    [zoom>=16] { line-width: 3; }
  }
  [type='stream'] {
    line-color: @water;
    line-width: 0.5;
    [zoom>=14] { line-width: 1; }
    [zoom>=16] { line-width: 2; }
    [zoom>=18] { line-width: 3; }
  }
}


// Landuse areas //

#landuse { 
  [class='school'] {
    polygon-fill: #E6E8DC;  
  }
  [class='park'], [class='pitch'],  {
    ::shadow {
   	 [zoom >= 16]{ 
        polygon-fill: #798C6B;
   	  	polygon-geometry-transform: translate(1,1);
      	polygon-opacity: 0.6;
      }
    }
    ::main {
       polygon-fill: @park; 
       polygon-pattern-file: url(grassTexture.jpg);
       polygon-pattern-comp-op: multiply;
       polygon-pattern-opacity: .2;
    }
  }
}

/*#area_label {
  [class='park'] {
    [zoom<=13],  // automatic area filtering @ low zooms
    [zoom>=14][area>500000],
    [zoom>=16][area>10000],
    [zoom>=17] {
      text-name: [name];
      text-face-name: 'Source Sans Pro Italic';
      text-fill: #333;
      text-size: 14;
      text-wrap-width: 100;
      text-wrap-before: true;
    }
  }
}*/

// Roads & Railways //

#tunnel { opacity: 0.5; }

#road::outline,
#tunnel::outline,
#bridge::outline {
  [class !='path'] {
    ['mapnik::geometry_type'=2] {
      line-color: #d7d7d7;
      [zoom >= 16] {
        line-geometry-transform: translate(-.5,-.5);
        line-opacity: 0.5;
      }
      [class='motorway'],[class='main'] {
        [zoom>=10] { line-width: 3; }
        [zoom>=12] { line-width: 5; }
        [zoom>=14] { line-width: 6; }
        [zoom>=16] { line-width: 12; }
      }
      [class='street'],
      [class='street_limited'] {
        [zoom>=14] { line-width: 4.5; }
        [zoom>=16] { line-width: 6; }
      }
    }
  }
}
#road,
#tunnel,
#bridge {
  ['mapnik::geometry_type'=2] {
    line-color: #fff;
    line-width: 0.5;
    [class='motorway'],
    [class='main'] {
      [zoom>=10] { line-width: 1; }
      [zoom>=12] { line-width: 2; }
      [zoom>=14] { line-width: 3; }
      [zoom>=16] { line-width: 9; }
    }
    [class='street'],
    [class='street_limited'] {
      [zoom>=14] { line-width: 2; }
      [zoom>=16] { line-width: 4; }
    }
    [class='street_limited'] { line-dasharray: 4,1; }
    [class='path'] {
     [zoom < 15] { 
       line-width: 0.4;
       line-color: #fff;
       line-opacity: 0.5;
       line-comp-op: screen;
     }
      [zoom >= 15] { 
      	line-width: 0.75;
        line-color: #fff;
        line-dasharray: 2,2;
        line-opacity: 0.75;
        line-comp-op: screen;
     }
       [zoom >= 17] { 
        line-width: 1;
        line-color: #fff;
        line-dasharray: 2,2;
        line-opacity: .75;
        line-comp-op: screen;
     }
    }
  }
}

#road_label::labels {
  [class != 'path'] {
    text-name: @name;
    text-face-name: 'Source Sans Pro Regular';
    [zoom <= 13] { 
      text-fill: #a9a9a9;
    }
    [zoom > 13] {
      text-fill: #8A8A8A;
    }
    text-size: 13;
    text-placement: line;
    text-wrap-width: 100;
    text-wrap-before: true;
    text-halo-fill: #fff;
    text-halo-radius: 2px;
    text-avoid-edges: true;
    text-min-distance: 75;
  }
}

// Buildings //

#building {
 ::shadow {
    [zoom>=14] {
      polygon-fill: #000;
      image-filters:agg-stack-blur(2,2);
      polygon-geometry-transform: translate(2,2);
      polygon-opacity: 0.1;
      polygon-comp-op: multiply;
  	}
  }
   ::shadow1 {
    [zoom>=16] {
      polygon-fill: #221E29;
      image-filters:agg-stack-blur(12,5);
      polygon-geometry-transform: translate(6,4);
      polygon-opacity: 0.1;
      polygon-comp-op: multiply;
  	}
  }
   ::shadow2 {
    [zoom>=16] {
      polygon-fill: #221E29;
      image-filters:agg-stack-blur(16,12);
      polygon-geometry-transform: translate(6,4);
      polygon-opacity: 0.1;
      polygon-comp-op: multiply;
  	}
  }
   ::highlight {
    [zoom>=16] {
      polygon-fill: #fcf7d6;
      polygon-geometry-transform: translate(-1,-1);
      image-filters:agg-stack-blur(3,3);
      polygon-opacity: .5;
      polygon-comp-op: screen;
  	}
  }
  ::highlight2 {
    [zoom>=16] {
      polygon-fill: #fcf7d6;
      polygon-geometry-transform: translate(1,1);
      polygon-opacity: 0.5;
      polygon-comp-op: screen;
  	}
  }
  polygon-fill: @building;
}


#poi_label::label {
  ['type'='Park'][localrank >= 2][zoom>=16] {
    text-name: [name];
    text-face-name: 'Source Sans Pro Regular';
    text-fill: #7D946C;
    text-size: 13;
    text-halo-fill: fadeout(#fff, 75%);
    text-halo-radius: 2px;
    [zoom>=18] {text-comp-op: multiply;}
  }
}
#poi_label {
  ['type'='Library'],['type'='Post Office'],
  ['type'='Theatre'], ['type'='Hospital'],
  ['type'='Public Building'], ['type'='Attraction'],
  ['type'='Sports Centre'], ['type'='Stadium'],
  ['type'='Arts Centre']{
    marker-file: url(@makiIcon);
    marker-fill: #9c9995;
    marker-line-color: #fff;
    marker-line-width: 2;
    marker-line-opacity: 1;
  }
}