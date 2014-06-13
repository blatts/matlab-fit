% -*- mode: Matlab -*-
% Time-stamp: "2011-09-21 18:45:10 sb"

%  file       Fit_JacobianToCI.m
%  copyright  (c) Sebastian Blatt 2010, 2011
%
%  This file is licensed under the Creative Commons Attribution 3.0
%  Unported License (see http://creativecommons.org/licenses/by/3.0).
%

function [dp,Cov] = Fit_JacobianToCI(J,residuals)
  % Calculate parameter errors from Jacobian J and RESIDUALS returned by a
  % Matlab fit routine. Do this by inverting the covariance matrix J'*J via
  % SVD. Rescale covariance with rms error and Student-t in the same way as
  % nlparci.

  m = size(J);
  DoF = m(1)-m(2); % Degrees of Freedom N_points - N_fitpars
  alpha = J'*J; % = d^2 chi^2 / (dp_i dp_j) Hessian of chi^2 at minimum
  %[U,S,V] = svds(alpha); % need svds since J returned by lsqnonlin is sparse
  [U,S,V] = svd(full(alpha));

  % Account for possible singular matrix alpha
  Sinv = zeros(m(2));
  for i=1:m(2),
    if S(i,i)>0, % svds returns positive definite S
      Sinv(i,i) = 1.0 / S(i,i);
    else
      Sinv(i,i) = 0; % set singular components to zero.
    end
  end

  Cov = V*Sinv*U';
  dp = sqrt(diag(Cov))' * sqrt(sum(sum(residuals.*residuals))/DoF) * tinv(.975,DoF);
end
