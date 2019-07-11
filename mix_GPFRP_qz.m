function YV=mix_GPFRP_qz(Theta,PI,T1,Y1,T2,MU)
%initialize
curve_number=numel(T1);
kk=numel(PI);
A=zeros(1,kk);
YV=cell(1,curve_number);


for i=1:curve_number
    % compute posterior
    Mle=zeros(1,kk);
%      phimat = getbasismatrix(T1{i},bsbasis);
% for ii = 1:Curve_num
%     for jj = 1:size(T1{1},1)
%     phimat{i}(jj,:) = bbase(T1{i}(jj),bsbasis,2);
%     end
%phi{ii} = getbasismatrix(xdata(ii,:),bsbasis);
% end
    for k=1:kk
%                 mu= phimat{i}*B(:,k);
        Mle(k)=-.5*MLE(Theta(k,:),dist(T1{i}').^2,(Y1{i}-MU(k,:))');
    end
    Mle=Mle-max(Mle);
    A=exp(Mle).*PI;
    A=A/sum(A);
    % prediction
    nt=size(T2{i},1);
    YV{i}=zeros(nt,2);
    for k=1:kk
        C=Theta(k,1)^2*exp(-Theta(k,2)^2/2*dist(T1{i}').^2)+...
            Theta(k,3)^2*eye(size(T1{i},1));
        L=chol(C)';
        %phimat = getbasismatrix(T1{i},bsbasis);
%         mu= phimat{i}*B(:,k);
        alpha=L'\(L\(Y1{i}-MU(k,:)));
        K=Theta(k,1)^2*exp(-Theta(k,2)^2/2*dist(T1{i},T2{i}').^2);
        Y(:,k)=K'*alpha;
        % compute expectation
        %YV{i}(:,1)=YV{i}(:,1)+Y*A(k); 
%         for jj = 1:size(T2{1},1)
%     phimat2(jj,:) = bbase(T2{i}(jj),bsbasis,2);
%     end
        % phimat = getbasismatrix(T2{i},bsbasis);
%         mu= phimat2*B(:,k);
        Y(:,k)=Y(:,k)+MU(:,k);
        % compute variance
        K_star=Theta(k,1)^2+Theta(k,3)^2;
        v=L\K;
       
        YV{i}(:,2)=YV{i}(:,2)+(K_star - diag(v'*v))*A(k);
    end
    YV{i}(:,1) = YV{i}(:,1) + Y*A';
  %  YV{i}(:,2)=YV{i}(:,2)-YV{i}(:,1).^2;
end
        

