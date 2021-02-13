%% Harmonic Wave Equation in 2D 
%  Finite Difference and Modes
%
%  Author: Ragini Bakshi, Feb 2021
%  Structure and Problem provided by: Professor Smy, 2021

set(0,'DefaultFigureWindowStyle','docked')
set(0, 'defaultaxesfontsize', 12)
set(0, 'defaultaxesfontname', 'Times New Roman')
set(0, 'DefaultLineLineWidth',2);

clear all
close all

nx = 50;
ny = 50;
V = zeros(nx,ny);
G = sparse(nx*ny, nx*ny);

for i = 1:nx
    for j = 1:ny
        m = j + (i - 1)*ny;
        mxm = j + (i - 2)*ny;
        mxp = j + (i)*ny;
        mym = j-1 + (i - 1)*ny;
        myp = j+1 + (i-1)*ny;
                
        if i == 1 || j == 1 || j == ny || i == nx       % sets diagonal 1 and all other values = 0
            G(m,:) = 0;
            G(m,m) = 1;
            
        elseif i > 10 && i < 20 && j > 10 && j < 20     % part ix: changing material has this effect
            G(m,m) = -2;
            G(m,mxm) = 1;
            G(m,mxp) = 1;
            G(m,mym) = 1;
            G(m,myp) = 1;
            
        else
            G(m,m) = -4;
            G(m,mxm) = 1;
            G(m,mxp) = 1;
            G(m,mym) = 1;
            G(m,myp) = 1;
        end
            
    end
end

figure('name', 'Matrix')
spy(G)

nmodes = 9;
[E,D] = eigs(G, nmodes, 'SM');

figure('name','Eigen Values')
plot(diag(D),'*');

np = ceil(sqrt(nmodes));
figure('name','Modes')
for k = 1:nmodes
    M = E(:,k);
    for i = 1:nx
        for j = 1:ny
            n = i + (j-1)*nx;
            V(i,j) = M(n);
        end
        subplot(np,np,k), surf(V, 'linestyle', 'none');
        title(['EV = ' num2str(D(k,k))]);
    end
end

