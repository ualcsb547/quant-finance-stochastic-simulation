% 1. Configuración de Parámetros (Basado en el PDF)
clear
clc
seed = 1234; 
rng(seed); 

U0 = 10000;         % Capital inicial (Superávit)
mu = -0.05;          % Drift anual (Margen de primas netas)
sigma = 1.20;       % Volatilidad anual de los siniestros
T = 1;              % Tiempo total (1 año)
N = 365;            % Pasos de tiempo (Diario)
M = 10000;          % Número de trayectorias (Simulación Monte Carlo) 

dt = T/N;           % Incremento de tiempo 
t = 0:dt:T;         % Vector de tiempo 

% 2. Pre-asignación de la Matriz de Capital
% Creamos una matriz donde cada columna es una simulación distinta
U = zeros(N + 1, M);
U(1, :) = U0; % Todas las trayectorias empiezan con el capital inicial 

% 3. Bucle para el resto 
for i = 1:M
    for k = 2:N+1
        epsilon = randn(); % Genera un número de la distribución normal estándar 
        
        % Evolución del capital basada en el Lema de Itô 
        U(k, i) = U(k-1, i) * exp((mu - 0.5 * sigma^2) * dt + sigma * epsilon * sqrt(dt));
        
        % Detección de Ruina: Si el capital llega a cero, la empresa
        % quiebra
       if U(k, i) <= 200  % Umbral de solvencia mínima
           U(k:end, i) = 0; 
           break;           
       end
        
    end
end


% 4.Gráficas
figure; 
subplot(2,1,1);
plot(t, U(:, 1:100)); % Graficamos las primeras 100 trayectorias para no saturar
title('Simulación de Reserva de Capital (Primeras 100 trayectorias)');
xlabel('Tiempo (Años)'); ylabel('Capital (U_t)');
grid on;

subplot(2,1,2); % Para dividir en dos el espacio de gráficas
histogram(U(end, :), 50, 'Normalization', 'pdf', 'FaceColor', [0.7 0.8 1]); 
title('Distribución Empírica del Capital al Final del Año');
xlabel('Capital Final'); ylabel('Densidad de Probabilidad');

% 5. Resultados
ruinas = sum(any(U <= 0, 1)); % Cuenta cuántas trayectorias tocaron el cero
prob_ruina = ruinas / M
capital_medio = mean(U(end, :))
intervalo_95 = quantile(U(end, :), [0.025, 0.975])
