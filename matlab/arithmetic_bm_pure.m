% 1. Configuración de Parámetros 
clear
clc
seed = 1234; 
rng(seed); % Semilla para que siempre nos salga igual

T = 100;                  % Tiempo total 
delta_t = 1/365;        % Paso de tiempo diario 
N = T/delta_t;          % Número de intervalos 
M = 10000;              % Número de trayectorias (Monte Carlo) 
U0 = 10;              % Capital inicial 

% Inicializamos y damos el valor de U en el momento inicial
U = zeros(N + 1, M);
U(1, :) = U0;           

% 2. Ejecución de M trayectorias (Algoritmo 1)
for i = 1:M
    for t = 2:(N + 1)
        % Generar epsilon (normal estándar, media 0) 
        eps = randn(); 
        
        % No hay mu, por lo que la media del incremento es 0
        U(t, i) = U(t-1, i) + eps * sqrt(delta_t);
        
        % Detección de Ruina 
        if U(t, i) <= 0
            U(t:end, i) = 0;
            % Al poner U(k:end, i) = 0, estamos diciendo que una vez que la 
            % empresa "muere", ya no puede seguir operando ni generar más dinero.
            % Si no pusiéramos esa línea, el Movimiento Browniano 
            % (que tiene media 0) podría hacer que el capital fuera negativo 
            % un día y "resucitara" mágicamente al día siguiente volviendo 
            % a ser positivo. Eso falsearía la probabilidad de ruina, porque 
            % en seguros lo que importa es si tocaste el fondo en algún momento.
            break;
        end
    end
end

% 3. Análisis de Riesgo (Resultados)
ruinas = sum(any(U <= 0, 1)); % Suma de todas las veces que U<=0
prob_ruina = (ruinas / M)
capital_medio = mean(U(end, :))
intervalo_95 = quantile(U(end, :), [0.025, 0.975]) % Intervalo de confianza al 95%

% Gráfica
figure;
plot(U(:, 1:100)); % Graficar solo 100 escenarios (para verlos más o menos)
title(['Probabilidad de Ruina: ', num2str(prob_ruina)]);
xlabel('Días'); ylabel('Reserva de Capital');
grid on;