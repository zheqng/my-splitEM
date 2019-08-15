function YP=mix_GPFRP_qz(Theta,PI,T1,Y1,T2,knots,B)
%initialize
curve_number=size(T1,1);
kk=length(PI);
A=zeros(1,kk);
% Mean = zeros
% YP = struct('mean',Mean , 'variance',Variance);
YP=cell(1,curve_number);


for ii=1:curve_number
    %     for jj = 1:size(T1,2)
    %         phimat{ii}(jj,:) = bbase(T1(ii,jj),bsbasis,2);
    %     end
    for jj = 0:(numel(knots)-4-1)
        phimat{ii}(:,jj+1) = bspline_basis(jj,4,knots,T1(ii,:));
    end
    % compute posterior
    Mle=zeros(1,kk);
    parfor k=1:kk
        mu= phimat{ii}*B(:,k);
        Mle(k)=-.5*MLE(Theta(k,:),dist(T1(ii,:)).^2,Y1(ii,:)-mu');
    end
    Mle=Mle-max(Mle);
    A=exp(Mle).*PI;
    A=A/sum(A);
    % prediction
    nt=size(T2(ii,:),2);
    YP{ii}=zeros(nt,2);
    for k=1:kk
        C=exp_cov_noise(T1(ii,:),Theta(k,:));
        %         Theta(k,1)^2*exp(-Theta(k,2)^2/2*dist(T1(ii,:)).^2)+...
        %             Theta(k,3)^2*eye(size(T1(ii,:),2));
        L=chol(C)';
        mu= phimat{ii}*B(:,k);
        K_inv_Y=L'\(L\(Y1(ii,:)'-mu));
        K_star=exp_cov(T1(ii,:),T2(ii,:),Theta(k,:));
        %         Theta(k,1)^2*exp(-Theta(k,2)^2/2*dist(T1(ii,:)',T2(ii,:)).^2);
        Y(:,k)=K_star'*K_inv_Y;
        % compute expectation
        %         for jj = 1:size(T2,2)
        %             phimat2(jj,:) = bbase(T2(ii,jj),bsbasis,2);
        %         end
        parfor jj = 0:(numel(knots)-4-1)
            phimat2(:,jj+1) = bspline_basis(jj,4,knots,T2(ii,:));
        end
        % phimat = getbasismatrix(T2{i},bsbasis);
        mu= phimat2*B(:,k);
        Y(:,k)=Y(:,k)+mu;
        % compute variance
        k_star=exp_cov(T2(ii,:)',T2(ii,:)',Theta(k,:));
        %         Theta(k,1)^2+Theta(k,3)^2;
        v=L\K_star;
        
        YP{ii}(:,2)=YP{ii}(:,2)+(k_star - diag(v'*v))*A(k);%variance
    end
    YP{ii}(:,1) = YP{ii}(:,1) + Y*A';%mean
    %  YP{i}(:,2)=YP{i}(:,2)-YP{i}(:,1).^2;
end




