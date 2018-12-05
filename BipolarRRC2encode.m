function [erros]=BipolarRRC2encode(EbNo_dB, n_bits, alpha,N,K)
%BipolarRRC2  Transmiss�o de bits em forma de pulsos bipolares formatados em
%raiz de cosseno levantado em canal AWGN com filtro casado.
%
% Ex: [erros]=BipolarRRC2(100, 10, 0.333, 7, 4)
%
%#Entradas:
% EbNo_dB = Rela��o sinal ru�do /SNR (energia do pulso RRC por densidade
% espectral de pot�ncia do ru�do)
% n_bits  = n�mero de bits
% alpha   = Roll-off do RRC, usar 0,333 se n�o especificado
% N       = n�mero de bits da sa�da do codificador
% K       = n�mero de bits da entrada do codificador
%
%#Sa�das:
% erros = quantidade de erros de bit

%Faz com que ru�dos sejam iguais sempre

Eb = 1;                 % Energia do sinal normalizada
EbNo = 10^(EbNo_dB/10); % Convers�o de dB para amplitude
No = Eb/EbNo;           % PSD do ru�do (vezes 2)
R=1;                    % Taxa de Transmiss�o em s�mbolos/s
T=1/R;                  % Per�odo de s�mbolo
dt = 0.2;              % Resolu��o do tempo
t=-(5*T):dt:(5*T);      % vetor de tempo para criar pulso RRC

%%%%%%%%
b = rand(1,n_bits)>0.5;    % Cria��o de bits equiprov�veis
%%%%%%%%
% codeHamm = encode(b, N, K, 'hamming'); %codifica��o de hamming
% codeHamm
b_pol = (b-1/2)*2;      % Sinaliza��o bipolar: 0 -> -1 e 1 -> 1 

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


%% Recep��o do sinal

% Sinal recebido pelo canal AWGN
n = sqrt(No/2)*randn(size(s)); % Ru�do AWGN com PSD No/2
r = s+n;                       % Sinal recebido com ru�do

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
disp(['erros = ',num2str(erros)]);




