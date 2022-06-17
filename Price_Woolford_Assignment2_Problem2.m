%
%Woolford Price
%Assignment 1, Problem 2
%Oct 12 2020
%


close all
clear
clc

load('FourClasses')
X = input("Measurement 1 = ")
Y = input("Measurement 2 = ")




%Code for LDA
mu1=mean(C1);
mu2=mean(C2);
mu3=mean(C3);
mu4=mean(C4);
mu =(mu1+mu2)/2;

%Determining the size of data per class
N1=size(C1);
N2=size(C2);
N3=size(C3);
N4=size(C4);
N = N1(1,1)+N2(1,1);

%Calculating the percent fo points in each class
P1=N1(1,1)/N;
P2=N2(1,1)/N;
P3=N3(1,1)/N;
P4=N4(1,1)/N;

%Calculating (C_i-mean_i)
D1 = C1-ones(N1)*diag(mu1);
D2 = C2-ones(N2)*diag(mu2);
D3 = C3-ones(N3)*diag(mu3);
D4 = C4-ones(N4)*diag(mu4);

%Caluclating the Covariances
S1=cov(C1);
S2=cov(C2);
S3=cov(C3);
S4=cov(C4);


%Creating the Sw and Sb Matrices
Sw=(N1(1,1)*S1+N2(1,1)*S2+N3(1,1)*S3+N4(1,1)*S4)/N;
Sb=(N1(1,1)*(mu1'-mu')*(mu1'-mu')'+N2(1,1)*(mu2'-mu')*(mu2'-mu')'+N3(1,1)*(mu3'-mu')*(mu3'-mu')'+N4(1,1)*(mu4'-mu')*(mu4'-mu')')/N;

[V,D] = eig(inv(Sw)*Sb);
[D order] = sort(diag(D),'descend');
V = V(:,order);

%Classifying the point 
Delta1= log(P1) - .5*mu1*V*V'*mu1' + mu1*V*V'*[X;Y];
Delta2= log(P2) - .5*mu2*V*V'*mu2' + mu2*V*V'*[X;Y];
Delta3= log(P3) - .5*mu3*V*V'*mu3' + mu3*V*V'*[X;Y];
Delta4= log(P4) - .5*mu4*V*V'*mu4' + mu4*V*V'*[X;Y];

if Delta1 > Delta2 && Delta1 > Delta3 && Delta1 > Delta4
    disp(['Data Point X = ', num2str(X), ' and Y = ', num2str(Y), ' is in Class 1'])
elseif Delta2 > Delta1 && Delta2 > Delta3 && Delta2 > Delta4
    disp(['Data Point X = ', num2str(X), ' and Y = ', num2str(Y), ' is in Class 2'])
elseif Delta3 > Delta1 && Delta3 > Delta2 && Delta3 > Delta4
    disp(['Data Point X = ', num2str(X), ' and Y = ', num2str(Y), ' is in Class 3'])
elseif Delta4 > Delta1 && Delta4 > Delta3 && Delta4 > Delta1
    disp(['Data Point X = ', num2str(X), ' and Y = ', num2str(Y), ' is in Class 4'])
else 
    disp(['Data Point X = ', num2str(X), ' and Y = ', num2str(Y), ' Lies on a boundary'])
end

