function [erros]=BipolarRRC2encode(EbNo_dB, n_bits, alpha,N,K)
%BipolarRRC2  Transmissão de bits em forma de pulsos bipolares formatados em
%raiz de cosseno levantado em canal AWGN com filtro casado.
%
% Ex: [erros]=BipolarRRC2(100, 10, 0.333, 7, 4)
%
%#Entradas:
% EbNo_dB = Relação sinal ruído /SNR (energia do pulso RRC por densidade
% espectral de potência do ruído)
% n_bits  = número de bits
% alpha   = Roll-off do RRC, usar 0,333 se não especificado
% N       = número de bits da saída do codificador
% K       = número de bits da entrada do codificador
%
%#Saídas:
% erros = quantidade de erros de bit

%Faz com que ruídos sejam iguais sempre

Eb = 1;                 % Energia do sinal normalizada
EbNo = 10^(EbNo_dB/10); % Conversão de dB para amplitude
No = Eb/EbNo;           % PSD do ruído (vezes 2)
R=1;                    % Taxa de Transmissão em símbolos/s
T=1/R;                  % Período de símbolo
dt = 0.2;              % Resolução do tempo
t=-(5*T):dt:(5*T);      % vetor de tempo para criar pulso RRC

%%%%%%%%
b = rand(1,n_bits)>0.5;    % Criação de bits equiprováveis
%%%%%%%%
% codeHamm = encode(b, N, K, 'hamming'); %codificação de hamming
% codeHamm
b_pol = (b-1/2)*2;      % Sinalização bipolar: 0 -> -1 e 1 -> 1 

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


%% Recepção do sinal

% Sinal recebido pelo canal AWGN
n = sqrt(No/2)*randn(size(s)); % Ruído AWGN com PSD No/2
r = s+n;                       % Sinal recebido com ruído

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
disp(['erros = ',num2str(erros)]);




