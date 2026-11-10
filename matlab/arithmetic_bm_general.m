% 1. Configuración de Parámetros (Basado en el PDF)
clear
clc
seed = 1234; 
rng(seed); % Para que los resultados sean replicables 

U0 = 10000;         % Capital inicial (Superávit)
mu = -50;          % Drift anual (Margen de primas netas)
sigma = 5000;       % Volatilidad anual de los siniestros (cuanto varía de arriba o abajo)
T = 1;              % Tiempo total (1 año)
N = 365;            % Pasos de tiempo (Diario)
M = 10000;          % Número de trayectorias (Simulación Monte Carlo) 

dt = T/N;           % Incremento de tiempo 
t = 0:dt:T;         % Vector de tiempo

% 2. Matriz de Capital
% Creamos una matriz donde cada columna es una simulación distinta
U = zeros(N + 1, M); % Cada fila representa un día diferente
U(1, :) = U0; % Todas las trayectorias empiezan con el capital inicial 


% 3. Bucle para el resto
for i = 1:M
    for k = 2:N+1
        epsilon = randn(); 
        
        % FORMULA SIMPLE (Aritmética)
        U(k, i) = U(k-1, i) + (mu * dt) + (sigma * epsilon * sqrt(dt));
        
        % Detección de Ruina Real
        if U(k, i) <= 0
            U(k, i) = 0;      % Forzamos que se quede en 0 al tocar fondo
            U(k+1:end, i) = 0; % La empresa ya no opera
            break;           
        end
    end
end

% 4. Doble gráfica

% Movimiento Browniano
figure;
subplot(2,1,1);
plot(t, U(:, 1:100)); % Graficamos las primeras 100 trayectorias para no saturar 
title('Simulación de Reserva de Capital (Primeras 100 trayectorias)');
xlabel('Tiempo (Años)'); ylabel('Capital (U_t)');
grid on;

% Histograma
subplot(2,1,2);
histogram(U(end, :), 50, 'Normalization', 'pdf', 'FaceColor', [0.7 0.8 1]); % 
title('Distribución Empírica del Capital al Final del Año');
xlabel('Capital Final'); ylabel('Densidad de Probabilidad');

% 5. Resultados
ruinas = sum(any(U <= 0, 1)); % Cuenta cuántas trayectorias tocaron el cero
prob_ruina = ruinas / M
capital_medio = mean(U(end, :))
intervalo_95 = quantile(U(end, :), [0.025, 0.975]) 
