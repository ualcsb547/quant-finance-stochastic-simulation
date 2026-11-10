function I = MCIS(f, a, b, n)

% Estima la integral simple de f(x) sobre [a, b]
% usando el Metodo de Monte Carlo.

% f: funcion a integrar 
% a, b: limites de integracion
% n: numero de puntos aleatorios

    % 1. Generar n puntos aleatorios uniformemente distribuidos en [a, b]
    % MATLAB's rand(n, 1) genera n numeros en [0, 1].
    % Para mapear a [a, b]: x = a + (b-a) * rand(n, 1);
    x = a + (b - a) * rand(n, 1);

    % 2. Evaluar la funcion en todos los puntos
    fx = f(x);

    % 3. Aplicar la formula de Monte Carlo
    % I = (b-a) * (suma(f(x_i)) / n)
    I = (b - a) * sum(fx) / n;
end