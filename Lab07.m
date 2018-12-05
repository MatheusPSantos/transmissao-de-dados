% Matheus Pereira dos Santos
% Lab 07

clc; clear all; close all;
%% Atividade 1

vetorSNRdB = -2:10; %vetor de Eb/No
vetorSNRw = 10.^(vetorSNRdB/10); %conversão para watts
vetorProbEr = qfunc(sqrt(2*vetorSNRw)); %vetor de probabilidade de erro
figure
semilogy(vetorSNRdB, vetorProbEr, 'k-');
ylabel('Probabilidade de Erro');
xlabel('Eb/No (dB)');
grid on
hold on

%% Atividade 2
n= 7; k = 3;
alpha = 0.333;
nbits = 100000;

vetEbNo = [-2:6, 6.5:0.5:9]; % Eb/No em dB

for k=1 : length(vetEbNo)
    [veterros(k)] = BipolarRRC2encode(vetEbNo(k), nbits, alpha, n, k);
end
semilogy(vetEbNo, veterros/nbits, 'r-d');

%% Atividade 3



