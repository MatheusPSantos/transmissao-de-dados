function [g,t,s]=BipolarRRC(EbNo_dB, n_bits, alpha);
%BipolarRRC  Transmissão de bits em forma de pulsos bipolares formatados em
%raiz de cosseno levantado em canal AWGN com filtro casado.
%
% Ex: BipolarRRC(100, 10, 0.333)
%
%#Entradas:
% EbNo_dB = Relação sinal ruído /SNR (energia do pulso RRC por densidade
% espectral de potência do ruído)
% n_bits  = número de bits
% alpha   = Roll-off do RRC, usar 0,333 se não especificado
%
%#Saídas:
% g = pulso RRC (raiz e cosseno levantado)
% t = vetor de tempo de t (10 segundos)
% s = vetor com sinal enviado no canal para FFT

clc;

Eb = 1;                 % Energia do sinal normalizada
EbNo = 10^(EbNo_dB/10); % Conversão de dB para amplitude
No = Eb/EbNo;           % PSD do ruído (vezes 2)
R=1;                    % Taxa de Transmissão em símbolos/s
T=1/R;                  % Período de símbolo
dt = 0.01;              % Resolução do tempo
t=-(5*T):dt:(5*T);      % vetor de tempo para criar pulso RRC


%b=[1 1 0 1 0 1 1 1 0 0 ];% vetor de bits de exemplo
b = rand(1,n_bits)>0.5;    % Criação de bits equiprováveis
b_pol = (b-1/2)*2;      % Sinalização bipolar: 0 -> -1 e 1 -> 1 

% Figura de bits com sinalização bipolar
figure
subplot(2,1,1)
stem(b_pol)
ylim([-1.3 1.3])          % ylim
set(gca,'xtick',1:10)     %fixa quais valores de x vão aparecer no plot
set(gca,'ytick',[-1 0 1]) %o mesmo pro eixo y
set(gca,'fontsize',12)    
xlabel('Bits')
ylabel('Amplitude Codificada')
title('Bits de informação com sinalização NRZ bipolar')

% Transformação do vetor de bits polarizados em vetor temporal 
% para convolução com o pulso RRC.
% baux1 contém uma matriz onde primeira linha tem b_pol
% e (1/dt-1)=99 linhas com zero
b_aux1 = [b_pol ; zeros(1/dt-1,length(b_pol))]; 
% b_aux1(:) transforma matriz em um vetor coluna
b_aux2 = b_aux1(:).';

g = rtrcpulse(alpha,t,T);   % Gera pulso RRC rtrcpulse(roll-off,vetor tempo,1/R)
Eg = sqrt(sum(g.^2));   % Eg= energia do pulso RRC
g = g/Eg;               % Normaliza energia do pulso para que Eb = 1

%% Transmissão dos sinal

% Formatação do sinal bipolar em pulsos RRC
% Filtragem de b_aux2 pelo filtro RRC por meio de convolução no tempo
% que é igual a multiplicação na frequência
s = conv(b_aux2,g);           %s (sent) é o sinal transmitido no canal

% Figura do sinal transmitido
ts = (0:length(s)-1)*dt ;      %vetor do tempo para plotar
tb_pol = (5:length(b_pol)+4);


subplot(2,1,2)
plot(ts, s)
hold on
stem(tb_pol,b_pol*0.12)
grid on
xlim([ts(1) ts(end)])
set(gca,'fontsize',12)
xlabel('Tempo [s]')
ylabel('Amplitude')
title('Sinal transmitido (azul) e NRZ bipolar')


%% Recepção do sinal

% Sinal recebido pelo canal AWGN
n = sqrt(No/2)*randn(size(s)); % Ruído AWGN com PSD No/2
r = s+n;                       % Sinal recebido com ruído

% Figura do sinal recebido
figure
subplot(2,1,1)
plot(ts,r)
grid on
set(gca,'fontsize',12)
xlim([ts(1) ts(end)])
xlabel('Tempo [s]')
ylabel('Amplitude')
title('Sinal recebido (r) do canal AWGN')

% Recepção usando filtro casado obtido com o uso do
% correlacionador e amostrador.

% y_int contém a saída do correlacionador
% tem que descontar o tamanho do pulso RCC (length(t)) do vetor y_int
y_int_length = length(r)-length(t)+1;
y_int = zeros(1,y_int_length);  
for k = 1:y_int_length
    idx = k:length(t) + k-1;     %vetor com tamanho do pulso RRC
    y_int(k) = sum(r(idx).*g);   %sum faz um integração discreta
end

% Amostrador1/
idx_amost = (0:1/dt:1/dt*length(b)-1)+1; % índice para amostragem
b_est = y_int(idx_amost) >0;             % bits estimados no receptor
erros = sum(abs(b - b_est));             % Erros na recepção

% Apresentação dos resultados
disp(['b(1:10) =     ',num2str(b(1:10))]);
disp(['b_est(1:10) = ',num2str(b_est(1:10))]);
disp(['erros = ',num2str(erros)]);

% Figura da saída do filtro casado separada em correlacionador e amostrador
ts2 = (1:length(y_int))*dt;      %vetor do tempo para plotar


subplot(2,1,2)
plot( ts2,y_int);             % Saída do correlacionador
hold on; grid on;
stem(ts2(idx_amost),y_int(idx_amost),'r');    % Saída do amostrador
set(gca,'fontsize',12)
xlabel('Tempo [s]')
ylabel('Amplitude')
title('Saída do filtro casado e sinal amostrado')

%% Diagrama de olho

n_simb=length(b);

figure
meio_per_simb = 1/(2*dt);
per_simb = 1/dt;
plot(ts2(meio_per_simb:per_simb-1) , y_int(1:meio_per_simb))
hold on

for k=1:n_simb-1
    y_int_ini = (2*k-1)*meio_per_simb;
    y_int_end = meio_per_simb + k*per_simb;
    plot(ts2(1:100) , y_int(y_int_ini :y_int_end-1))
end
set(gca,'fontsize',12)
xlabel('Período  de um símbolo [s]')
ylabel('Amplitude')
title('Diagrama de olho')

grid on



