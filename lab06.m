% Matheus Pereira dos Santos
% Lab 06 - Codificação de Huffman

clc, clear all;
%% Atividade 1

% a)
% resultado do comando help huffmandict

symbols = [1:5]; % Vetor de Alfabeto
prob = [.3 .3 .2 .1 .1]; % Vetor de probabilidades
[dict, avglen] = huffmandict(symbols, prob)

% impressão dicionário
temp = dict;
for i = 1:length(temp)
    temp{i,2} = num2str(temp{i,2});
end
temp

% b)
symbols = [0:4];
prob = [.4 .2 .2 .1 .1];

[dicionario, avglen] = huffmandict(symbols, prob)
temp = dict;
for i = 1:length(temp)   
    temp{i,2} = num2str(temp{i,2});
end
temp


% c)
% O comprimento médio da codificação é
avglen

%d)
sig = [0 3 1 0 2 4 0 1 2 3];
sig_encoded = huffmanenco(sig, dicionario)
sig_encoded

% e)
deco = huffmandeco(sig_encoded, dicionario)'
% f)
% checando se deco é igual ao vetor sig
eq = isequal(sig, deco)

%% Atividade 2

symbols = [1:6]; % Distinct symbols that data source can produce 
p = [.5 .125 .125 .125 .0625 .0625]; % Probability distribution 
[dict,avglen] = huffmandict(symbols,p);% Create dictionary. 
dict
avglen
actualsig = randsrc(100,1,[symbols; p]); % Create data using p. 
actualsig'
comp = huffmanenco(actualsig,dict); % Encode the data.
comp'

% a) A Função randsrc cria um vetor de sinais baseado no dicionário de
% código
% b)
deco = huffmandeco(comp, dict);
eq = isequal(actualsig, deco);
deco'
eq

% c) O tamanho médio da palavra-código , L, depende do tamanho de cada
% palavra-código
 L = avglen;
 tmp = symbols;
 Lmin = 0;
 for i = 1: length(tmp)
     Lmin = Lmin + (tmp(i)*(log2(1/tmp(i))));
 end
 
 % eficiencia da codificação:
 n = Lmin/L;
 n
     
