function A = A_init(Y,kk)
[curve_num,Nm] = size(Y);

for m=1:curve_num
    for i3=1:3
        Y_vector(m,i3)=mean(Y(m,(round((i3-1)*Nm/3+1)):(round(i3*Nm/3))));
    end
end

A=zeros(curve_num,kk);
for i3=1:3
    percents=[];
    A_tmp{i3}=zeros(curve_num,kk);
    for i1=1:kk+1
        percents(i1)=100*(i1-1)/kk;
    end
    M6=[];
    M6=prctile(Y_vector(:,i3),percents);
    for m=1:curve_num
        for ki=1:kk
            if Y_vector(m,i3)>=M6(ki)&&Y_vector(m,i3)<=M6(ki+1)
                A_tmp{i3}(m,ki)=1;
            end
        end
    end
    A=A+A_tmp{i3};
end
% for ki=1:kk
%     M6=[];
%     M6=prctile(A(:,ki),[20,80]);
%     A=min(A,M6(2));
%     A=max(A,M6(1));
% end
% A=A-M6(1);
% for m=1:curve_num
%     if max(A(m,:))>=1
%         A(m,:)=A(m,:)/sum(A(m,:),2);
%     else A(m,:)=ones(1,kk)/kk;
%     end
% end

for m=1:curve_num  
        A(m,:)=A(m,:)/sum(A(m,:),2);
end