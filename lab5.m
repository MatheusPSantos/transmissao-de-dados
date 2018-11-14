% Laboratório 05
% Matheus Pereira dos Santos

% Filtro casado, Pulso cos levantado e Probabilidade de erro

%% Atividade 01

[g,t,s] = BipolarRRCsf(100, 10, 0.333);

figure
plot(t,g, '-r')
grid on
ylabel('Amplitude')
xlabel('tempo em segundos')
title('Raiz de cosseno levantado')