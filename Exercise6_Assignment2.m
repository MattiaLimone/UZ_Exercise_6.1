%% MP, Exercise 6, Assignment 2
% Dual PCA method
clc; close all; clear;

figure(1); clf;
P = load('points.txt') ;
N = size(P, 2);
plot(P(1,:),P(2,:),'+'); hold on;
for i = 1:N
   text( P(1,i)-0.5, P(2,i), num2str(i)); 
end
xlabel('x_1'); ylabel('x_2');
xlim([-10 10]);
ylim([-10 10]);

%% 2a - Dual method
M = size(P, 1);
mu = mean(P, 2);
Xd = P - mu;
C = 1/(M-1) * (Xd.' * Xd);

expectedS = [8.1898 1.6102];
[Ut, St, Vt] = svd(C);
U = Xd * Ut / sqrt((M-1) * St);

%% 2b - Projection and reprojection
Ptran = U.' * Xd;
Pback = (U.' \ Ptran) + mu;
correst = all(all(P == Pback));