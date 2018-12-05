% Matheus Pereira dos Santos
% Lab 07

clc; clear all; close all;
%% Atividade 1

vetorSNRdB = -2:10; %vetor de Eb/No
vetorSNRw = 10.^(vetorSNRdB/10); %conversão para watts
vetorProbEr = qfunc(sqrt(2*vetorSNRw)); %vetor de probabilidade de erro
figure
semilogy(vetorSNRdB, vetorProbEr, 'k-');
legend('Não Codificado','Location','SouthOutside');
ylabel('Probabilidade de Erro')
xlabel('Eb/No (dB)')
grid on
hold on

%% Atividade 2
n= 7; k = 3;
alpha = 0.333;
nbits = 100000;

vetEbNo = [-2:6, 6.5:0.5:9]; % Eb/No em dB

for i=1 : length(vetEbNo)
    [veterros(i)] = BipolarRRC2encode(vetEbNo(i), nbits, alpha, n, k);
end

semilogy(vetEbNo, veterros/nbits, 'r-d');
legend('Codificado com (7,3)', 'Location', 'SouthOutside');

%% Atividade 3
n = 15; k = 11;
a = 100000;
a = a-mod(a, k);

for i = 1 : length(vetEbNo)
    [veterros(i)] = BipolarRRC2encode(vetEbNo(i), a, alpha, n, k);
end

semilogy(vetEbNo, veterros/a, 'g-d');
legend('Codificado com (15,11)', 'Location', 'SouthOutside');
hold on

%% Atividade 4
n = 31; k = 26;
a = 100000;
a = a-mod(a, k);
for i=1 : length(vetEbNo)
    [veterros(i)] = BipolarRRC2encode(vetEbNo(i), a, alpha, n, k);
end

semilogy(vetEbNo, veterros/a, 'b-d');
legend('Codificado com (31,26)', 'Location', 'SouthOutside');
hold on

%% Atividade 5
n = 127; k = 120;
a = 100000;
a = a-mod(a, k);
for i = 1 : length(vetEbNo)
    [veterros(i)] = BipolarRRC2encode(vetEbNo(i), a, alpha, n, k);
end

semilogy(vetEbNo, veterros/a, 'r-d');
legend('Codificado com (127,120)','Location','SouthOutside');

