taux = 0:.025:1; % sites where NURBS basis function is to be computed in the x direction
tauy = 0:.025:1; % sites where NURBS basis function is to be computed in the y direction

% Description of NURBS basis functions
% x direction
xweights = [1 1 1 3 1 1 1];             % weight vector 
knotsx = [0 0 0 0 .25 .5 .75 1 1 1 1];  % knot sequence
px = 3;                                 % cubics
% y direction
yweights = [1 1 1 3 1 1 1];             % weight vector
knotsy = [0 0 0 0 .25 .5 .75 1 1 1 1];  % knot sequence
py = 3;                                 % cubics

[plotBasis1x,plotDbasis1x] = nurbscol(knotsx,px+1,brk2knt(taux,px),xweights);
[plotBasis1y plotDbasis1y] = nurbscol(knotsy,py+1,brk2knt(tauy,py),yweights);

% plot(taux, plotBasis1x)   % plot of univariate basis function in the x
                            % direction

[X,Y] = meshgrid(taux,tauy);


for j = 1:size(plotBasis1y,2)
    Nj = plotBasis1y(:,j);
    B = zeros(size(plotBasis1y,1),size(plotBasis1y,2));
    B(:,j) = Nj;
        for i=1:size(plotBasis1x,2)
            Ni = plotBasis1x(:,i);
            A = zeros(size(plotBasis1x,1),size(plotBasis1x,2));
            A(:,i) = Ni;
            globalIndice = size(plotBasis1x,2)*(j-1)+i;
            figure(globalIndice)
            surf(X,Y,A*ones(size(plotBasis1x,2),size(plotBasis1y,2))*B');
            
            axis([0 1 0 1 0 1])
            %set(CData,'scaled')
            Movie(globalIndice)=getframe(gcf,[0 0 414 560]);
        end
end

% movie2avi(Movie,'BasisFunctions.avi','fps',6,'quality',100); %removed in MATLAB R2016

basisFunctions = VideoWriter('BasisFunctions.avi');
open(basisFunctions);
writeVideo(basisFunctions,Movie);
close(basisFunctions);
