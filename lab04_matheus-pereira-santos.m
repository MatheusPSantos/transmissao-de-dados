% Transmiss�o de dados
% Matheus Pereira dos Santos
%% Exerc�cio 1
% Observa��o do efeito Aliasing
N = 5000;    % N�mero de amostras
fm = 10;    % frequ�ncia da mensamgem

%%% fs=200; 
fs=200;               %frequ�ncia de amostragem
Ts=1/fs;              %per�odo de amostragem
t=(0:N-1)*Ts;         %vetor do tempo
m = cos(2*pi*fm*t);   %sinal de mensagem
M1= fft(m)/N;
M= abs(2*M1(1:N/2+1));      %Fourier "one-sided" 
f=linspace(0,fs/2,N/2+1);   %vetor com frequ�ncias em Hz

figure
subplot(1,2,1)
plot(t,m,'*-')
xlim([0 1])
grid on
str1 = ['fs = ' num2str(fs)];   %str1 � um vetor de strings 
ylabel(str1)

subplot(1,2,2)
fs2x=[fs/2 fs/2];   %vetores para demonstrar fs/2 na figura
fs2y=[0 max(M)];    %n�o aparece na primeira figura com fs=200
plot(f,M,fs2x,fs2y,'r--','LineWidth',2)
grid on
xlim([0 20])
% ---------------------
%%% fs = 20 Hz
fs = 20;   % frequ�ncia de amostragem
Ts = 1/fs;  % per�odo de amostragem
temp = (0:N-1)*Ts;  % vetor do tempo
m = cos(2*pi*fm*temp);  % sinal de mensagem
M2 = fft(m)/N;
M = abs(2*M2(1:N/2+1)); % Fourier "one-sided"
f1 = linspace(0, fs/2, N/2+1);   % Vetor com frequ�ncias em Hz

figure
subplot(1,2,1)
plot(t, m, 'g')
xlim([0 1])
grid on
str1 = ['fs = ' num2str(fs) 'Hz'];   %str1 � um vetor de strings
ylabel(str1)

subplot(1,2,2)
fs2x = [fs/2 fs/2]; %vetores para demonstrar fs/2 na figura
fs2y = [0 max(M)];
plot(f1, M, 'g:', fs2x, fs2y, 'r--', 'LineWidth', 2);
grid on
xlim([0 20])
%----------------------
%%% fs = 15 Hz
fs = 15;    % frequ�ncia de amostragem igual a 15Hz
Ts = 1/fs;  %per�odo de amostragem para a frequ�ncia atual
temp = (0: N-1)*Ts;  % vetor de tempo
m = cos(2*pi*fm*temp);  % sinal de mensagem
M3 = fft(m)/N; % transformada de fourier r�pida
M = abs(2*M3(1:N/2+1)); % M�dulo "one-side"
f2 = linspace(0, fs/2, N/2+1);   % Vetor com frequ�ncias em Hz

figure
subplot(1,2,1)
plot(t, m, '*-')
xlim([0 1])
grid on
str2 = ['fs = ' num2Str(fs) 'Hz'];  % vetor de strings para legenda
ylabel(str2);

subplot(1,2,2)
fs2x = [fs/2 fs/2]; % vetor para fs/2
fs2y = [0 max(M)];
plot(f2, M, 'r:', fs2x, fs2y, 'g--', 'LineWidth', 2);
grid on
xlim([0 20])



