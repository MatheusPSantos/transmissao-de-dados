% Laboratório 05
% Matheus Pereira dos Santos

% Filtro casado, Pulso cos levantado e Probabilidade de erro

%% Atividade 01
%%% - Plotando o pulso de raiz de cosseno levantado (RRC) com alpha = 0.333

[g,t,s] = BipolarRRC_CosLevantado(100, 10, 0.333);

figure
plot(t,g, '-r')
grid on
ylabel('Amplitude')
xlabel('tempo em segundos')
title('Pulso Raiz de Cosseno Levantado')

%% Atividade 02
% Para Eb/No = 100dB e 10 bits na Atividade 1, foram apresentados 0 erros
% de decodificação.
% Checando para Eb/No = -10dB
[g1, t1, s1] = BipolarRRC_CosLevantado(-10, 10, 0.333);
% ------------------------------------------------
% Na primeira execução da seção foram encontrados:
% b(1:10) =     0  0  1  1  1  0  1  0  1  0
% b_est(1:10) = 0  0  0  0  1  0  0  0  0  0
% erros = 4
% ------------------------------------------------
% Na segunda execução da seção os erros foram:
% b(1:10) =     1  1  0  1  1  0  1  1  1  0
% b_est(1:10) = 1  1  1  1  0  1  0  1  0  0
% erros = 5
%-------------------------------------------------
% Na publicação, os erros:

%% Atividade 03
% Checando o diagram de olho:

[g2,t2,s2] = BipolarRRC_DiagOlho(100, 10, 1);
legend('Para Relação sinal ruído /SNR igual a 100dB e fator roll-off igual a 1.', 'Location','SouthOutside')

[g3,t3,s3] = BipolarRRC_DiagOlho(100, 10, 0.333);
legend('Para Relação sinal ruído /SNR igual a 100dB e fator roll-off igual a 0,333.','Location','SouthOutside')

[g4,t4,s4] = BipolarRRC_DiagOlho(100, 10, 0);
legend('Para Relação sinal ruído /SNR igual a 100dB e fator roll-off igual a 0.','Location','SouthOutside')
