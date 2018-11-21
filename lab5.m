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

%O pulso para alpha = 0 será cortado. Isso porque a onda quadrada corta o
%a raíz de cosseno levantado antes do tempo. Isso causa inconsistência e
%interferência entre os pulsos.

%% Atividade 04

vetEbNo = [-10, -5, 0, 5, 7, 8, 10];    % vetor de relações sinais ruídos em dB
%percorrendo e plotando para o vetor de relações sinais rúidos
clc;
for k = 1 : length(vetEbNo)
   [g5, t5, s5, erros30(k)] = BipolarRRC_NoGraph(vetEbNo(k), 30, 0.333);
end

figure

semilogy(vetEbNo, erros30/30, 'r-d')
ylabel('Probabilidade de erro de bit')
xlabel('Relação Sinal Ruído/SNR (dB)')
grid on
hold on

%% Atividade 05

% Repetindo para o Número de Bits igual a 10000
% percorrendo o vetor de relaçãoes sinal rupido
for k = 1 : length(vetEbNo)
    [g6, t6, s6, erros10000(k)] = BipolarRRC_NoGraph(vetEbNo(k), 10000, 0.333);
end

semilogy(vetEbNo, erros10000/10000, 'r-s');

%% Atividade 06

vetorSNRDB = -10:10;    % vetor de SNR -10 a 10 dB
vetorSNRW =10.^(vetorSNRDB/10);     % conversão para watts

vetorProbEr = qfunc(sqrt(2*vetorSNRW)); % vetor de probabilidade de erro
semilogy(vetorSNRDB, vetorProbEr, 'b-s');
legend('Pe teórico por Eb/No (dB)','Location','SouthOutside');

%% Atividade 07

% Para SNR aproximadamente a 5dB o Diagrama de olho já está fechando no
% diagrama.
figure
title('Diagrama de olho para SNR igual a 5dB e Numero de bits igual a 1000')
BipolarRRC_DiagOlho(5, 1000, 0.333);
