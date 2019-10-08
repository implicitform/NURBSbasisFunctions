function[nurbs_bf,nurbs_dbf] = nurbscol(knots,k,tau,weights)

%---PROGRAM P8-1

% 2016: Prof. C. Provatidis, and Aris Papangelakis, NTUA

%-------------------------------------------------------------------------------------------------
%NOMENCLATURE
%...Input variables:
% knots : knot row-vector
% k	: order (=degree of piecewise polynomial + 1)
% tau	: row-vector including points where the basis functions are to be calculated
% weights: row-vector including the weights that correspond to control points
% ...Output variables:
% nurbs_bf : matrix including the basis functions Nj,p relevant to control points Pj
% nurbs_dbf: matrix including the first derivatives of basis functions Nj,p
%-------------------------------------------------------------------------------------------------


bsplines_basis_functions = spcol(knots,k,tau);
bspline_bf = bsplines_basis_functions(1:k-1:end,:); % basis functions
bspline_dbf = bsplines_basis_functions(2:k-1:end,:);% 1st derivatives 
                                                  % of basis functions

% Calculation of rational NURBS basis functions :
for i = 1:size(bspline_bf,1)		
	for j = 1:size(bspline_bf,2)
		nurbs_bf(i,j) = bspline_bf(i,j)*weights(j)/sum(bspline_bf(i,:).*weights);
	end
end

% Calculation of first derivatives of rational NURBS basis functions :
for i = 1:size(bspline_dbf,1)		
	for j = 1:size(bspline_dbf,2)
		nurbs_dbf(i,j) = weights(j)*(sum(bspline_bf(i,:).*weights)*bspline_dbf(i,j)- ...
                             sum(bspline_dbf(i,:).*weights)*bspline_bf(i,j))/...
                             (sum(bspline_bf(i,:).*weights))^2;
	end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
