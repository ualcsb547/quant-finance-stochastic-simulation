function [I,n_aceptados] = MCID_triangulo(f,a,b,c,d,n)
% a,b,c,d son los vértices de la región rectángular en la que está dentro
% el triángulo que queremos aproximar su área.
% Puntos aleatorios que dibujaremos
x=(b-a)*rand(n,1)+a; 
y=(d-c)*rand(n,1)+c;

indices_aceptados = y<= 2 - x;
x_triang = x(indices_aceptados);
y_triang = y(indices_aceptados);
n_aceptados = length(x_triang);
z=feval(f,x_triang,y_triang);

% Para la gráfica voy a hacer una que se muestren los puntos aceptados y
% los que no junto a la recta que los divide (2-x)
indices_rechazados = y > 2 - x;
x_rechazados = x(indices_rechazados);
y_rechazados = y(indices_rechazados);
figure
plot(x_triang,y_triang,'*r')
hold on
plot(x_rechazados,y_rechazados,'*b')
hold on
plot([0,2], [2,0], 'k-')
legend('Puntos aceptados', 'Puntos rechazados', 'Línea de separación')

I = ((b-a).*(d-c)./(2.*n_aceptados)).*sum(z);
end