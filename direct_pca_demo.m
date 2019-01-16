function direct_pca_demo()
 
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

mu = mean(P, 2);
Xd = P - mu;
C = 1/(N-1) * (Xd * Xd.');

[U, S, V] = svd(C);
eigs = diag(S); % Vector of eigen values
draw_gauss2d(mu, C, 'r', 1)
hold on;
% First eigen vector
t1 = V(:, 1);
t1 = t1 * S(1, 1);
t1 = t1+mu;
plot([t1(1), mu(1)], [t1(2), mu(2)], 'g');
% Second eigen vector
t2 = V(:, 2);
t2 = t2 * S(2, 2);
t2 = t2+mu;
plot([t2(1), mu(1)], [t2(2), mu(2)], 'r');

% Variance accordinxg to eigen values
eigsPlot = eigs/(sum(eigs));
figure(2);
firstLabel = ['First eigen value: ', num2str(eigsPlot(1)*100, 3), '%'];
secondLabel = ['Second eigen value: ', num2str(eigsPlot(2)*100, 3), '%'];
labels = {firstLabel, secondLabel};
pie(eigs, labels);
title('Variance dependance on eigen values');

% Get rid of diemnsion of the smallest (=second) eigen value
Ptran = U * Xd;
Ptran(2, :) = 0; % Erase second dimension
Pback = U \ Ptran;
Pback = Pback + mu;
figure(1);
% plot(P(1,:),P(2,:),'+'); hold on;
plot(Pback(1,:),Pback(2,:),'o');
% xlabel('x_1'); ylabel('x_2');
% xlim([-10 10]);
% ylim([-10 10]);

figure(4);
draw_reconstructions(P, Pback);
xlim([-10 10]);
ylim([-10 10]);

end

