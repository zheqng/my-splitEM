function [GG,L3,A3]=mixGPFRl(T,Y,k1,T1,jq)
% mix-GPFR,soft
% M10=[];M10=T{1};T=[];T=M10;M10=[];M10=Y{1};Y=[];Y=M10;


M34=1;
js1=0;
M35=nthroot(1/M34,js1+1);
M36=M34;



fg=size(T1,2);
fg=fg-2*jq-1;
d2=fg+jq;
m=numel(Y);
[n,d3]=size(T{1});
mZ=d3+1;




for i=1:m
    P{i}=[T{i} Y{i}];
end

%????Fai
for i=1:m
    for j=1:n
        P{i}(j,mZ+1:mZ+d2)=bbase(P{i}(j,1:d3),T1,jq);
    end
end

for i=1:m
    D{i}=dist(P{i}(:,1:d3)').^2;
end


G4=2*rand(k1,3);%超参数
for i=1:m
    for i3=1:3
        M7(i,i3)=mean(Y{i}((round((i3-1)*n/5+1)):(round(i3*n/5))));
    end
end

A=zeros(m,k1);
for i3=1:3
    M5=[];
    A1{i3}=zeros(m,k1);
    for i1=1:k1+1
        M5(i1)=100*(i1-1)/k1;
    end
    M6=[];
    M6=prctile(M7(:,i3),M5);
    for i=1:m
        for i1=1:k1
            if M7(i,i3)>=M6(i1)&&M7(i,i3)<=M6(i1+1)
                A1{i3}(i,i1)=1;
            end
        end
    end
    A=A+A1{i3};
end
for i1=1:k1
    M6=[];
    M6=prctile(A(:,i1),[20,80]);
    A=min(A,M6(2));
    A=max(A,M6(1));
end
A=A-M6(1);
for i=1:m
    if max(A(i,:))>eps(0)
        A(i,:)=A(i,:)/sum(A(i,:),2);
    else A(i,:)=ones(1,k1)/k1;
    end
end
A4=A;

%????Fai
for i=1:m
    for i2=1:n
        HE{i}(i2,:)=bbase(T{i}(i2,:),T1,jq);
    end
end

M20=-inf;
js=0;
pd=9;
while (pd>10^(-2.7)) && (js<js1+50)
    js=js+1;
    A2=A;
    M36=min(M36*M35,1);
    %????????
    %参数pi
    G0=sum(A,1)/m;
   
    %????B,sita
    for i1=1:k1
        if max(A(:,i1))>=eps(0)
            AQ=A(:,i1)/max(A(:,i1));
        else
            AQ=rand(m,1);
        end
        M2=0;
        M3=0;
        for i=1:m
            C=G4(i1,1)^2*exp(-.5*G4(i1,3)^2*D{i})+G4(i1,2)^2*eye(n);
            M2=M2+AQ(i)*P{i}(:,mZ+1:end)'*(C\P{i}(:,mZ+1:end));
            M3=M3+AQ(i)*P{i}(:,mZ+1:end)'*(C\P{i}(:,2));
        end
        if rank(M2)==size(M2,1)
            G5(i1,:)=(M2\M3)';%参数B
        else G5(i1,:)=((M2+.000000001*eye(d2))\M3)';
        end
        
        %????y-miu
        for i=1:m
            M4{i}=[];
            M4{i}=P{i}(:,2)-P{i}(:,mZ+1:end)*G5(i1,:)';
        end
        options2=optimset('MaxFunEvals',10^20);
        [G4(i1,:) fval4]=fminsearch(@(YHL) my_function5(YHL,AQ,D,M4),G4(i1,:),options2);
    end
    
    

    %!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    
     %????alfa
    A=mixGPFRalpha({G0,G4,G5},D,Y,HE,M36);
    A3{js}=A;
       %% Q??????
    L3(js)=Q_function4({G0,G4,G5},P,D,A,d3);
    if (js>js1+.1)&&(L3(js)>=M20)
        M20=L3(js);
        GG=[];
        GG={G0,G4,G5};
    end
    if js>js1+9.1
        pd=(mean(L3(js-4:js))-mean(L3(js-9:js-5)))/abs(mean(L3(js-9:js-5)));
    end
    
end


M8=find(GG{1}<(min(2/m,1/(2*k1))));
if numel(M8)>.5
    GG=delmixGPFR(GG,M8);
end
