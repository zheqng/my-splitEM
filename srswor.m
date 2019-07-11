function [rn, restn] = srswor(a,c)
%Randomly select c numbers from 1 to a
%rn: selected numbers
%restn: the rest a-c numbers


%Method 1:
%A similar matlab function:  randperm() 
% rn = zeros(1,c);
% restn = zeros(1,a-c);
% 
% i=1;
% while i<=c
%     r = unidrnd(a);
%     if sum(rn(1,1:(i-1))==r*ones(1,(i-1)))==0
%         rn(1,i) = r;
%         i = i+1;
%     end
% end
% 
% rn=sort(rn);
% 
% j=1;
% for i=1:a
%     if sum(rn==i*ones(1,c))==0
%         restn(1,j) = i;
%         j = j+1;
%     end
% end


%Method 2: use randperm()

r0 = randperm(a);
r1 = r0(1,1:c);
r2 = r0(1,c+1:a);

rn = sort(r1);
restn = sort(r2);