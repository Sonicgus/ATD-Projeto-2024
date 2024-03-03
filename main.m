%Exercícios 1 e 2
clear;
close all;
clc;

ficheiros = '.\data\04\';

figure;

for digit = 0:9
    % escolher um exemplo
    fileNum = randi([0, 49]);

    % importar sinais de audio
    filename = [ficheiros num2str(digit) '_04_' num2str(fileNum) '.wav'];
    [y, Fs] = audioread(filename);

    sound(y, Fs);
    duracao = length(y)/Fs;
    subplot(5, 2, digit+1);
    time = 1/Fs:1/Fs:duracao;
    plot(time,y);
    title(['Dígito ' num2str(digit) ', ficheiro ' num2str(fileNum)]);
    xlabel('Tempo (s)');
    ylabel('');
    pause(.5+duracao);
end
%% 
%Exercícios 3 e 4
close all;
clear;
clc;

ficheiros = '.\data\04\';

arrayDesviopadrao = zeros(10,50);
arrayEm = zeros(10,50);
arrayEnergiaTotal = zeros(10,50);

for digit = 0:9
    for fileNum = 0:49
        % importar sinais de audio
        filename = [ficheiros num2str(digit) '_04_' num2str(fileNum) '.wav'];
        [y, Fs] = audioread(filename);
        
        % obter amplitude maxima do som
        maxAmp = max(abs(y));
        
        % Normalizar o som
        y = y./maxAmp;
        
        % remover silencio inicial
        indice = find(abs(y) > 0.05, 1,"first");
        y(1:indice) = [];

        % remover silencio final
        y=flipud(y);
        indice = find(abs(y) > 0.05, 1,"first");
        y(1:indice) = [];
        y=flipud(y);
        
        arrayEnergiaTotal(digit+1, fileNum+1) = sum(abs(y).^2);
        arrayEm(digit+1, fileNum+1) = arrayEnergiaTotal(digit+1, fileNum+1)./length(y);
        arrayDesviopadrao(digit+1, fileNum+1) = std(y);
    end
end

arrayAux = repmat(0:9, 1, 50);

figure;
% Gráfico de Desvio Padrão
subplot(3,1,1);
plot(arrayAux, reshape(arrayDesviopadrao, 1, []), 'o');
title('Desvio Padrão');
xlabel('Dígitos');
ylabel('Dp');

% Gráfico de Energia Média
subplot(3,1,2);
plot(arrayAux, reshape(arrayEm, 1, []), 'o');
title('Energia Média');
xlabel('Dígitos');
ylabel('Em');

% Gráfico de Energia Total
subplot(3,1,3);
plot(arrayAux, reshape(arrayEnergiaTotal, 1, []), 'o');
title('Energia Total');
xlabel('Dígitos');
ylabel('Energia');
