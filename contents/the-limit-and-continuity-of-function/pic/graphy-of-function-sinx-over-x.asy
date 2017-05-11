
import geometry;
import graph;

size(150);

real foo(real x) {
  return sin(x) / x;
}

real positivescale(real x) {
  return 1 / x;
}

real negativescale(real x) {
  return -1 / x;
}

path pl = graph(foo, -8, -0.01, operator..);
draw(pl);
path p2 = graph(foo, 0.01, 8, operator..);
draw(p2);
path p3 = graph(positivescale, -8, -0.7, operator..);
draw(p3, dashed);
path p4 = graph(positivescale, 0.7, 8, operator..);
draw(p4, dashed);
path p5 = graph(negativescale, -8, -0.7, operator..);
draw(p5, dashed);
path p6 = graph(negativescale, 0.7, 8, operator..);
draw(p6, dashed);


xaxis("$x$", Arrow);
yaxis("$y$", Arrow);
