function [eigenV, mu] = dualPCA(input)
[M, ~] = size(input);

mu = mean(input, 1);
Xd = input - mu;
Xd = Xd.'; % Transpose matrix so it agrees with previous assignment
C = (1/(M-1)) .* (Xd.' * Xd);

[Ut, St, ~] = svd(C);
s = diag(St) + 1e-15; % Extract the diagonal as a vector and add a small constant
Si = diag(1 ./ sqrt((M - 1) .* s)); % Compute the inverse and construct a diagonal matrix
% Si = diag(sqrt((M - 1) * s)); % Compute the inverse and construct a diagonal matrix

U = Xd * (Ut * Si);
eigenV = U.'; % Transpose to agree with input
end