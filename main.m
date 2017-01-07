clear
clc

% [A, toleranta, iteratiiMax] = readMatrix;

A = rand(42);
toleranta = 10^(-25);
iteratiiMax = 200;

[vecProp, matErr, matVec] = metoda_puterii_inverse(A, toleranta, iteratiiMax);

vecProp
matErr;
matVec;

% disp('Valori proprii cu eig')
% eig(A)
disp('Verificare')
lambda = max(eig(A));
A*vecProp - lambda*vecProp

nrIteratie = [1:iteratiiMax+1];

figure
plot(nrIteratie,matErr(:,1))
grid on
xlabel('Iteratii')
title('Eroarea')