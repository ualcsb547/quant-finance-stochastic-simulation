function [I,x,y] = MC_malla(f, a, b, c, d, nx, ny)
% I = IMalla(f, a, b, c, d, nx, ny)
%
% Estima la integral doble de f(x, y) sobre [a, b] x [c, d]
% usando una malla rectangular (Regla del Punto Medio Compuesta).
%
% f: función a integrar (por ejemplo, @(x,y) cos(x.*y))
% a, b: límites de integración para x
% c, d: límites de integración para y
% nx: número de divisiones en la dirección x
% ny: número de divisiones en la dirección y

    % 1. Calcular el tamaño de paso y el área de cada subrectángulo
    hx = (b - a) / nx; % Tamaño de paso en x
    hy = (d - c) / ny; % Tamaño de paso en y
    DeltaA = hx * hy;   % Área de cada subrectángulo

    % 2. Generar los puntos centrales de la malla (punto medio)
    % Las coordenadas x de los puntos centrales
    x_i = a + hx/2 + (0:(nx-1)) * hx;

    % Las coordenadas y de los puntos centrales
    y_j = c + hy/2 + (0:(ny-1)) * hy;

    % 3. Crear la malla de puntos (meshgrid)
    % X e Y son matrices con las coordenadas de todos los puntos centrales
    [x, y] = meshgrid(x_i, y_j);

    % 4. Evaluar la función en todos los puntos de la malla
    z = feval(f,x, y);
   

    % 5. Sumar los valores de la función y multiplicar por el área del subrectángulo
    % La integral es la suma de f(x_i, y_j) * DeltaA
   
    I = sum(sum(z)) * DeltaA;

    % Nota: El número total de puntos es n = nx * ny
end