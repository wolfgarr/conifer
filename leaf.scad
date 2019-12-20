/**
* This file contains a 2D vector representation of your InkScape file.
* You can set the global variable "$fn" to alter the precision of the curves.
* You should use "linear_extrude" or "rotate_extrude" to give it some volume.
*/
/*
translate([-39.77277, 47.63229]) {
	layer1();
}
*/
// Group ID: layer1
module leafImport() {
	translate([-39.77277, 47.63229]) {
		// Path ID: path841
		bezier_polygon([[[77.790281, -19.1322898], [72.746751, -4.001706799999999], [53.952051, -0.13229169999999968], [39.790285999999995, -0.13228699999999982]], [[39.790285999999995, -0.13228699999999982], [25.628534, -0.13228239999999936], [6.815294999999999, -4.0572748], [1.7902909999999999, -19.1322898]], [[1.7902909999999999, -19.1322898], [-3.2347149999999996, -34.2073038], [3.8994989999999987, -48.2264108], [13.260642999999998, -64.74603579999999]], [[13.260642999999998, -64.74603579999999], [22.621782999999997, -81.2656608], [35.981532, -95.1322898], [39.79028099999999, -95.1322898]], [[39.79028099999999, -95.1322898], [43.599042999999995, -95.1322898], [56.552992, -81.3682378], [65.954072, -64.9035978]], [[65.954072, -64.9035978], [75.35516199999999, -48.4389578], [82.833811, -34.2628718], [77.790281, -19.1322898]], [[77.790281, -19.1322898], [77.790281, -19.1322898], [77.790281, -19.1322898], [77.790281, -19.1322898]], [[77.790281, -19.1322898], [77.790281, -19.1322898], [77.790281, -19.1322898], [77.790281, -19.1322898]]]);
	}
}

/**
* Stripped down version of "bezier_v2.scad".
* For full version, see: https://www.thingiverse.com/thing:2170645
*/

function BEZ03(u) = pow((1-u), 3);
function BEZ13(u) = 3*u*(pow((1-u),2));
function BEZ23(u) = 3*(pow(u,2))*(1-u);
function BEZ33(u) = pow(u,3);

function bezier_2D_point(p0, p1, p2, p3, u) = [
	BEZ03(u)*p0[0]+BEZ13(u)*p1[0]+BEZ23(u)*p2[0]+BEZ33(u)*p3[0],
	BEZ03(u)*p0[1]+BEZ13(u)*p1[1]+BEZ23(u)*p2[1]+BEZ33(u)*p3[1]
];

function bezier_coordinates(points, steps) = [
	for (c = points)
		for (step = [0:steps])
			bezier_2D_point(c[0], c[1], c[2],c[3], step/steps)
];

module bezier_polygon(points) {
	steps = $fn <= 0 ? 30 : $fn;
	polygon(bezier_coordinates(points, steps));
}
