function ab11 = celltomatconv(seg)

%this function used for the cell to matrix conversion, if cell contain
%unequal matrices. Normal cell2mat function cant convert unequal matrices
%in cell to matrix.
%
%seg  : this is cell containing unequal matrices.
%ab11 : output single matrix converted from cell
%
% created on : 24/4/2017.
% created by : jayant kulkarni, JV technologies.
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

b1=seg{2};
a1=seg{1};
[xa,ya]=size(a1);
[xb,yb]=size(b1);
if xa>xb
    z=0;
    %k=xb;
    for k=xb:xa-1
    b1=[b1(1:k,:);z;b1(k+1:end,:)];
    end
else
    %Xba=xb-xa;
    z=0;
    %k=xa; %xa+1;
    for k=xa:xb-1
     a1=[a1(1:k,:);z;a1(k+1:end,:)];
     %k=k+1;

    end
end

size(a1)
size(b1)

ab11=horzcat(a1,b1);

%A = [1,1; 2,2; 3,3]; 
% b = 0; 
% k = 0; %row position, can be 0,1,2 or 3 in this case
%A = [A(1:k,:); b; A(k+1:end,:)]
%ab11=horzcat(a1,b1);
%ab11=ab11';
%wavplay(ab11)
%ab11=ab11';

end