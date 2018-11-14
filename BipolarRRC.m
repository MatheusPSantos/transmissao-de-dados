function [g,t,s]=BipolarRRC(EbNo_dB, n_bits, alpha);
%BipolarRRC  Transmiss�o de bits em forma de pulsos bipolares formatados em
%raiz de cosseno levantado em canal AWGN com filtro casado.
%
% Ex: BipolarRRC(100, 10, 0.333)
%
%#Entradas:
% EbNo_dB = Rela��o sinal ru�do /SNR (energia do pulso RRC por densidade
% espectral de pot�ncia do ru�do)
% n_bits  = n�mero de bits
% alpha   = Roll-off do RRC, usar 0,333 se n�o especificado
%
%#Sa�das:
% g = pulso RRC (raiz e cosseno levantado)
% t = vetor de tempo de t (10 segundos)
% s = vetor com sinal enviado no canal para FFT

clc;

Eb = 1;                 % Energia do sinal normalizada
EbNo = 10^(EbNo_dB/10); % Convers�o de dB para amplitude
No = Eb/EbNo;           % PSD do ru�do (vezes 2)
R=1;                    % Taxa de Transmiss�o em s�mbolos/s
T=1/R;                  % Per�odo de s�mbolo
dt = 0.01;              % Resolu��o do tempo
t=-(5*T):dt:(5*T);      % vetor de tempo para criar pulso RRC


%b=[1 1 0 1 0 1 1 1 0 0 ];% vetor de bits de exemplo
b = rand(1,n_bits)>0.5;    % Cria��o de bits equiprov�veis
b_pol = (b-1/2)*2;      % Sinaliza��o bipolar: 0 -> -1 e 1 -> 1 

% Figura de bits com sinaliza��o bipolar
figure
subplot(2,1,1)
stem(b_pol)
ylim([-1.3 1.3])          % ylim
set(gca,'xtick',1:10)     %fixa quais valores de x v�o aparecer no plot
set(gca,'ytick',[-1 0 1]) %o mesmo pro eixo y
set(gca,'fontsize',12)    
xlabel('Bits')
ylabel('Amplitude Codificada')
title('Bits de informa��o com sinaliza��o NRZ bipolar')

% Transforma��o do vetor de bits polarizados em vetor temporal 
% para convolu��o com o pulso RRC.
% baux1 cont�m uma matriz onde primeira linha tem b_pol
% e (1/dt-1)=99 linhas com zero
b_aux1 = [b_pol ; zeros(1/dt-1,length(b_pol))]; 
% b_aux1(:) transforma matriz em um vetor coluna
b_aux2 = b_aux1(:).';

g = rtrcpulse(alpha,t,T);   % Gera pulso RRC rtrcpulse(roll-off,vetor tempo,1/R)
Eg = sqrt(sum(g.^2));   % Eg= energia do pulso RRC
g = g/Eg;               % Normaliza energia do pulso para que Eb = 1

%% Transmiss�o dos sinal

% Formata��o do sinal bipolar em pulsos RRC
% Filtragem de b_aux2 pelo filtro RRC por meio de convolu��o no tempo
% que � igual a multiplica��o na frequ�ncia
s = conv(b_aux2,g);           %s (sent) � o sinal transmitido no canal

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


%% Recep��o do sinal

% Sinal recebido pelo canal AWGN
n = sqrt(No/2)*randn(size(s)); % Ru�do AWGN com PSD No/2
r = s+n;                       % Sinal recebido com ru�do

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

% Recep��o usando filtro casado obtido com o uso do
% correlacionador e amostrador.

% y_int cont�m a sa�da do correlacionador
% tem que descontar o tamanho do pulso RCC (length(t)) do vetor y_int
y_int_length = length(r)-length(t)+1;
y_int = zeros(1,y_int_length);  
for k = 1:y_int_length
    idx = k:length(t) + k-1;     %vetor com tamanho do pulso RRC
    y_int(k) = sum(r(idx).*g);   %sum faz um integra��o discreta
end

% Amostrador1/
idx_amost = (0:1/dt:1/dt*length(b)-1)+1; % �ndice para amostragem
b_est = y_int(idx_amost) >0;             % bits estimados no receptor
erros = sum(abs(b - b_est));             % Erros na recep��o

% Apresenta��o dos resultados
disp(['b(1:10) =     ',num2str(b(1:10))]);
disp(['b_est(1:10) = ',num2str(b_est(1:10))]);
disp(['erros = ',num2str(erros)]);

% Figura da sa�da do filtro casado separada em correlacionador e amostrador
ts2 = (1:length(y_int))*dt;      %vetor do tempo para plotar


subplot(2,1,2)
plot( ts2,y_int);             % Sa�da do correlacionador
hold on; grid on;
stem(ts2(idx_amost),y_int(idx_amost),'r');    % Sa�da do amostrador
set(gca,'fontsize',12)
xlabel('Tempo [s]')
ylabel('Amplitude')
title('Sa�da do filtro casado e sinal amostrado')

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
xlabel('Per�odo  de um s�mbolo [s]')
ylabel('Amplitude')
title('Diagrama de olho')

grid on



