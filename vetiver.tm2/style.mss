// Languages: name (local), name_en, name_fr, name_es, name_de
@name: '[name_en]';

// Common Colors //
@water: #c3e6ff;
@park: #e3ead6;

Map {
  background-color:#f4f4f4;
}


// Political boundaries //

#admin {
  line-join: round;
  line-color: #bbe;
  [maritime=1] { line-color: darken(@water, 3%); }
  // Countries
  [admin_level=2] {
    line-width: 1.4;
    [zoom>=6] { line-width: 2; }
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
  text-fill: #66a;
  text-size: 12;
  [zoom>=3][scalerank=1],
  [zoom>=4][scalerank=2],
  [zoom>=5][scalerank=3],
  [zoom>=6][scalerank>3] {
    text-size: 14;
  }
  [zoom>=4][scalerank=1],
  [zoom>=5][scalerank=2],
  [zoom>=6][scalerank=3],
  [zoom>=7][scalerank>3] {
    text-size: 16;
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
    [zoom>=10] { text-size: 18; }
    [zoom>=12] { text-size: 24; }
  }
  [type='town'][zoom<=17] {
    text-name: @name;
    text-face-name: 'Source Sans Pro Regular';
    text-fill: #444;
    text-size: 14;
    text-wrap-width: 100;
    text-wrap-before: true;
    text-halo-fill: #fff;
    text-halo-radius: 2px;
    [zoom>=10] { text-size: 16; }
    [zoom>=12] { text-size: 20; }
  }
  [type='village'] {
    text-name: @name;
    text-face-name: 'Source Sans Pro Regular';
    text-fill: #444;
    text-size: 14;
    text-wrap-width: 100;
    text-wrap-before: true;
    [zoom>=12] { text-size: 14; }
    [zoom>=14] { text-size: 17; }
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
    text-halo-fill: #fff;
    text-halo-radius: 2px;
    [zoom>=14] { text-size: 14; }
    [zoom>=16] { text-size: 16; }
  }
}


// Water Features //

#water {
  polygon-fill: @water;
  polygon-gamma: 0.6;
}

#water_label {
  [zoom<=13],  // automatic area filtering @ low zooms
  [zoom>=14][area>500000],
  [zoom>=16][area>10000],
  [zoom>=17] {
    text-name: @name;
    text-face-name: 'Source Sans Pro Italic';
    text-fill: darken(@water, 30%);
    text-size: 13;
    text-wrap-width: 100;
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
    [class='park'] {
    ::shadow {
   	  polygon-fill: #798C6B;
   	  polygon-geometry-transform: translate(1,1);
      polygon-opacity: 0.6;
    }
    ::main {
       polygon-fill: @park; 
       polygon-pattern-file: url(grass.jpg);
       polygon-pattern-comp-op: multiply;
       polygon-pattern-opacity: .2;
    }
  }
}

#area_label {
  [class='park'] {
    [zoom<=13],  // automatic area filtering @ low zooms
    [zoom>=14][area>500000],
    [zoom>=16][area>10000],
    [zoom>=17] {
      text-name: @name;
      text-face-name: 'Source Sans Pro Italic';
      text-fill: darken(@park, 50%);
      text-size: 14;
      text-wrap-width: 100;
      text-wrap-before: true;
    }
  }
}

// Roads & Railways //

#tunnel { opacity: 0.5; }

#road::outline,
#tunnel::outline,
#bridge::outline {
  ['mapnik::geometry_type'=2] {
    line-color: #d7d7d7;
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
      line-color: #fff;
      line-width: 1;
      line-dasharray: 2,2;
      line-opacity: 0.75;
      line-comp-op: screen;
    }
  }
}

#road_label::labels {
   text-name: @name;
    text-face-name: 'Source Sans Pro Regular';
    text-fill: #a9a9a9;
    text-size: 15;
    text-placement: line;
    text-wrap-width: 100;
    text-wrap-before: true;
    text-halo-fill: #fff;
    text-halo-radius: 2px;
    text-avoid-edges: true;
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
      polygon-geometry-transform: translate(10,6);
      polygon-opacity: 0.1;
      polygon-comp-op: multiply;
  	}
  }
   ::highlight {
    [zoom>=16] {
      polygon-fill: #F5E1C9;
      polygon-geometry-transform: translate(-1,-1);
      image-filters:agg-stack-blur(3,3);
      polygon-opacity: .8;
      polygon-comp-op: screen;
  	}
  }
  ::highlight2 {
    [zoom>=16] {
      polygon-fill: #fff;
      polygon-geometry-transform: translate(1,1);
      polygon-opacity: 0.75;
      polygon-comp-op: screen;
  	}
  }
  polygon-fill: #D9D2CA;
}

