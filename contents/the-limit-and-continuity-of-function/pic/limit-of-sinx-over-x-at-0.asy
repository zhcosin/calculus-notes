
import geometry;

size(120);

pair O = (0, 0);
label("$O$", O, SW);
real r = 1, theta = pi / 4;
path mycircle = circle(O, r);
draw(mycircle);

pair A = (r, 0);
pair B = (r, r * tan(theta));
pair C = (r * cos(theta), r * sin(theta));
pair D = (r * cos(theta), 0);

label("$A$", A, SE);
label("$B$", B, NE);
label("$C$", C, N);
label("$D$", D, S);

draw(O -- A -- B -- cycle);
draw(C -- D);
