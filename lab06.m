% Matheus Pereira dos Santos
% Lab 06 - Codificação de Huffman

%% Atividade 1

% a)
% resultado do comando help huffmandict

symbols = [1:5]; % Vetor de Alfabeto
prob = [.3 .3 .2 .1 .1]; % Vetor de probabilidades
[dict, avglen] = huffmandict(symbols, prob);

% impressão dicionário
temp = dict;
for i = 1:length(temp)
    temp{i,2} = num2str(temp{i,2});
end
temp;

% b)
symbols = [0:4];
prob = [.4 .2 .2 .1 .1];

[dicionario, avglen] = huffmandict(symbols, prob);

% c)
% O comprimento médio da codificação é
avglen;

%d)
sig = [0 3 1 0 2 4 0 1 2 3];
sig_encoded = huffmanenco(sig, dicionario);
sig_encoded;

