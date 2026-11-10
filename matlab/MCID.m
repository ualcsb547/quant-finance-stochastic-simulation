function [I,x,y]=MCID(f,a,b,c,d,n)
% Puntos aleatorios que dibujaremos
x=(b-a)*rand(n,1)+a; % +a es para que empiece en a para que esté entre a y b
y=(d-c)*rand(n,1)+c;
z=feval(f,x,y);
plot(x,y,'*r')
I=((b-a)*(d-c)/n)*sum(z);