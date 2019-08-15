function [BIC,Theta,PI,A,B,component_num]=SMGPFRL1(T,Y,knots)
kmax=30;
kk=1;
% initialization
m=size(T,1);
Nm = size(T,2);Curve_num = m;
A = ones(Curve_num,1);

phi=cell(1,m);
zmat = ones(m,1);
% % % % % % % % % % % % % % r
for ii = 1:Curve_num
    D{ii}=dist(T(ii,:)).^2;
    for jj = 0:(numel(knots)-4-1)
        phi{ii}(:,jj+1) = bspline_basis(jj,4,knots,T(ii,:));
    end
    %     for jj = 1:Nm
    %         phi{ii}(jj,:) = bbase(T(ii,jj),bsbasis,2);
    %     end
end
[Theta,PI]=Theta_PI_init(kk);

%____________________prepare for iterations___________________%
final=false;
[Theta,PI,A,B]=EM(D,Y,Theta,PI,A,phi);
% B_iter{1} = B;
% compare_meanfunction(T,phi,B);
d=repmat(0.5,1,kmax);
d(1)=0;
d(end)=1;
b=flip(d);
split_threshold=1;
loglik=LogLik(D,Y,Theta,PI,B,phi);
% BIC=-2*loglik+4*kk*log(Curve_num*Nm);
BIC=-2*loglik++(4+numel(knots)-4)*kk*log(Nm);
%  BIC=-2*loglik;

component_num=[];
%______________________start iterations_________________________%
while final==false
    %________________substract the mean func______________________________%
    [~,cluster]=max(A,[],2);
%     figure;plot(cluster,'.')
    pause(1)
    %         figure;
    %         plot_curve(T,Y,cluster);
    %          title(['components number=',num2str(kk)])
    %     zmat = zeros(Curve_num,kk);
    %     for ii=1:Curve_num
    %         zmat(ii,cluster(ii))=1;
    %     end
    parfor ii = 1:Curve_num
        MY(ii,:)=Y(ii,:) - ( phi{ii}*B(:,cluster(ii)))';
    end
    %_______________-split the mean func curves______________________%
    [ratio,final,Theta_new,PI_new]=split_criterion2(D,MY,Theta,PI,loglik,d,b);
    
    %     close all;
    if random('unif',0,1,1)<ratio
        %         split=true;
        %___________fix k moves_______________________________%
        A_new=posterior_update(D,MY,Theta_new,PI_new);
        [Theta_new,PI_new,A_new,B_new]=EM(D,Y,Theta_new,PI_new,A_new,phi);
        [Theta_new,PI_new,B_new]=delcomp(Theta_new,PI_new,A_new,B_new);
        A_new=posterior_update(D,Y,Theta_new,PI_new,B_new,phi);
        %__________calc BIC___________________________________%
        kk=length(PI_new)
        loglik_new=LogLik(D,Y,Theta_new,PI_new,B_new,phi);
%                 BIC = [BIC -2*loglik_new+4*kk*log(Curve_num*Nm)];
        BIC = [BIC -2*loglik_new+(4+numel(knots)-4)*kk*log(Nm)];
       BIC_tmp= [2*loglik_new+2*loglik (4+numel(knots)-4)*log(Nm)]
        
        %          BIC = [BIC -2*loglik_new]
        %___________judge final via BIC_________________________%
        if BIC(end)>BIC(end-1)
             split = false;
           
        else
            split = true;
            component_num = [component_num kk];
            %______________update parameters________________________%
            Theta=Theta_new;
            PI=PI_new;
            B = B_new;
            loglik = loglik_new;
            A = A_new;
%             compare_meanfunction(T,phi,B);
        end
        %         %____________if not final, split; if final break_________________%
        %         if final == false
        %             component_num = [component_num kk];
        %             %             %_____________plot figure_______________________________%
        % %              A_new=posterior_update(D,MY,Theta_new,PI_new);
        % %             [~,cluster]=max(A_new,[],2);
        %             %             figure;
        %             %             plot_curve(T,Y,cluster);
        %             %             pause(1)
        %             %______________update parameters________________________%
        %             Theta=Theta_new;
        %             PI=PI_new;
        %             B = B_new;
        %             loglik = loglik_new;
        %             A = A_new;
        %              compare_meanfunction(T,phi,B);
        %         end
    end
end
% end
% plot(BIC);hold on;
% plot(BIC,'.');hold off
