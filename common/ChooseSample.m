function [ x_training,y_training,x_testing,y_testing,index_training, index_testing, A, U, AA, UU ] = ChooseSample( dataSetName, nTrEachClass, nSeed, normType, radius, data)
% Randomly split HSI data to training and testing data 
% Input:
% dataSetName: HSI data downloaded from http://alweb.ehu.es/ccwintco/index.php?title=Hyperspectral_Remote_Sensing_Scenes
% nTrEachClass: 
%         >1: the number of training data chosen from each class
%         0-1:  the percentage of data to be training data chosen from each class
% nSeed: Random function seed
% normType: Methods to normlize X
% radius: Choose neighbors in the window with the radius around the center x_i
% re_options.type = 'CR'
% re_options.reg = 1e-3;
% re_options.garma = 1e-3;
% options.beta = 1e-3);
% %options.mode='standard';
% re_options.mode='extend'; %re_options.lambda=1;
% %re_options.mode='magic'; %re_options.epsilon=0.05;
% %re_options.mode='slep'; re_options.k=5;
% 
% Output:
% x_training: NxD training data where each row is a sample
% y_training: Nx1 labels correponding to the training data
% x_test: NNxD testing data where each row is a sample
% x_test: NNx1 labels correponding to the testing data
% index_training: index of training data
% index_testing: index of testing data
% A: neighbors included training data (radius>0)
% U: index of neighbors for training data
% AA: neighbors included testing data (radius>0)
% UU: index of neighbors for testing data 


% rng(10,'twister');
% s= rng;
if ~exist('nSeed','var')
    nSeed = 0;
end

if ~exist('normType','var')
    normType = 1;
end

if ~exist('radius','var')
    radius = 0;   %
end

switch dataSetName
	case 'Indianpines' 
        load('./dataset/Indian_pines_corrected.mat');load('./dataset/Indian_pines_gt.mat');
        x = indian_pines_corrected;y = indian_pines_gt;
    case 'KSC'      
        load('./dataset/KSC.mat');load('./dataset/KSC_gt.mat');
        x = KSC;y = KSC_gt;
    case 'Salinas'    
        load('./dataset/Salinas_corrected.mat');load('./dataset/Salinas_gt.mat');
        x = salinas_corrected;y = salinas_gt;
    case 'SalinasA' 
	   load('./dataset/SalinasA_corrected.mat');load('./dataset/SalinasA_gt.mat');
	   x = salinasA_corrected; y = salinasA_gt;
    case 'Pavia' 
	   load('./dataset/Pavia.mat');load('./dataset/Pavia_gt.mat');
	   x = pavia; y = pavia_gt;
    case 'PaviaU' 
	   load('./dataset/PaviaU.mat');load('./dataset/PaviaU_gt.mat');
	   x = paviaU; y = paviaU_gt;
	case 'Botswana'
        load('./dataset/Botswana.mat');load('./dataset/Botswana_gt.mat');
        x = Botswana;y = Botswana_gt;
    case 'Urban4'
        load('./dataset/Urban_R162.mat');load('./dataset/end4_groundTruth.mat');
        Urban = reshape(Y', 307,307,162); [uMax, Urban_gt] =max(A); Urban_gt = reshape(Urban_gt, 307,307);
        Urban_gt(307, 307) = 0;             %to be compatible  with  nClass = size(ind,1)-1; 
        x = Urban;y = Urban_gt;
    case 'Urban5'
        load('./dataset/Urban_R162.mat');load('./dataset/end5_groundTruth.mat');
        Urban = reshape(Y', 307,307,162); [uMax, Urban_gt] =max(A); Urban_gt = reshape(Urban_gt, 307,307);
        Urban_gt(307, 307) = 0;             %to be compatible  with  nClass = size(ind,1)-1; 
        x = Urban;y = Urban_gt;
    case 'Urban6'
        load('./dataset/Urban_R162.mat');load('./dataset/end6_groundTruth.mat');
        Urban = reshape(Y', 307,307,162); [uMax, Urban_gt] =max(A); Urban_gt = reshape(Urban_gt, 307,307);
        Urban_gt(307, 307) = 0;             %to be compatible  with  nClass = size(ind,1)-1; 
        x = Urban;y = Urban_gt;
    case 'Indianpines5' 
        load('./dataset/Indian_pines_5class.mat');
%         x = indian_pines_corrected;y = indian_pines_gt;
    case 'Earthquake'
        addpath('E:/History Matching/EarthquakeData');
        load('well_corrected.mat','well_corrected');load('well_gt.mat','well_gt');
        x = well_corrected;y = well_gt;
        clear well_corrected well_gt;
    otherwise
        error('Unknown data set requested.');
end

if exist('data','var')
    x = data;   % use the data as x
end


xClean = x;

% smoothing
if radius > 0
    for i=1:size(x,3);
        x(:,:,i) = imfilter(x(:,:,i),fspecial('average',radius));
    end
end

% save([dataSetName '-Smooth-R' num2str(radius) '.mat']);
% return;

Dim = size(x);
ind = tabulate(y(:));
nClass = size(ind,1)-1;    %except label=0 
xClean=reshape(xClean,Dim(1)*Dim(2),Dim(3));
x=reshape(x,Dim(1)*Dim(2),Dim(3));
y=reshape(y,Dim(1)*Dim(2),1);


xClean = sgpNormalize( xClean, normType );
x = sgpNormalize( x, normType );
 
 %È¡Êý¾Ý
y_training=[];%ÑµÁ·Ñù±¾µÄ±êÇ©
x_training=[];%ÑµÁ·Ñù±¾
y_testing=[];%²âÊÔÑù±¾µÄ±êÇ©
x_testing=[];%²âÊÔÑù±¾
row_training=[]; %ÑµÁ·Ñù±¾ÔÚÕæÊµÊý¾ÝÖÐµÄÐÐ×ø±ê
col_training=[];%ÁÐ×ø±ê
row_testing=[];%²âÊÔÑù±¾ÔÚÕæÊµÊý¾ÝÖÐµÄÐÐ×ø±ê
col_testing=[];%ÁÐ×ø±ê
index_training=[];
index_testing=[];
% index_zero = find(y==ind(1,1));
nMaxPercent = 0.6;      %max percentage of data chosen from each class

nTrEachInit = nTrEachClass;
 for i=1:nClass
     nTrEachClass = nTrEachInit;
     % choose training data according to the percentage from each class
     if nTrEachClass < 1
         if nTrEachClass <= 0
             error('Please check input: nTrEachClass');
         end
        A= find(y==ind(i+1,1));
        nTrEachClass = round(length(A)*nTrEachClass);
        %min number of data chosen from each class
        %which void that small number of testing data cause problem for KNN
        %in graph embedding
       if nTrEachClass < 5
           nTrEachClass = 5;
       end

       rng((i+nSeed)*10,'twister');
       randomorder = randperm(length(A));
%        x_training = [x_training;x(A(randomorder(1:nTrEachClass)),:)];
%        y_training = [y_training;y(A(randomorder(1:nTrEachClass)),:)];
%        x_testing = [x_testing;x(A(randomorder(nTrEachClass+1:end)),:)];
%        y_testing = [y_testing;y(A(randomorder(nTrEachClass+1:end)),:)];
       index_training = [index_training;A(randomorder(1:nTrEachClass))];
       index_testing = [index_testing;A(randomorder(nTrEachClass+1:end))];
     else        
         % choose training data according to the number from each class
        A= find(y==ind(i+1,1));
        %max percentage of data chosen from each class
        %which void that all data from some class to be training data
        %leading to no testing data
        if round(length(A)*nMaxPercent) < nTrEachClass    
            nTrEachClass = round(length(A)*nMaxPercent);
        end
        %N=size(A,1)*0.14;
       % d=round(N);%ËÄÉáÎåÈë
       rng((i+nSeed)*10,'twister');
       randomorder = randperm(length(A));
%        x_training = [x_training;x(A(randomorder(1:nTrEachClass)),:)];
%        y_training = [y_training;y(A(randomorder(1:nTrEachClass)),:)];
%        x_testing = [x_testing;x(A(randomorder(nTrEachClass+1:end)),:)];
%        y_testing = [y_testing;y(A(randomorder(nTrEachClass+1:end)),:)];
       index_training = [index_training;A(randomorder(1:nTrEachClass))];
       index_testing = [index_testing;A(randomorder(nTrEachClass+1:end))];
%     b=A(1:nTrEachClass);
%     row_training=[row_training;mod(b,1096)];
%     col_training=[col_training;ceil(b/715)];
%     %È¡10%×öÑµÁ·Ñù±¾
%     for j1=1:length(b)
%         y_training=[y_training;z(b(j1))];
%     end
%     x_training=[x_training;y(b,:)];
%     %È¡Ê£ÏÂµÄ×ö²âÊÔÑù±¾
%     M=round((numel(A))*0.08);
%     f=A(101:M);
%     row_test=[row_test;mod(f,1096)];%²âÊÔÑù±¾ÔÚÕæÊµÊý¾ÝÖÐµÄÐÐ×ø±ê
%     col_test=[col_test;ceil(f/715)];%ÁÐ×ø±ê
%     for j1=1:length(f)
%         y_test=[y_test;z(f(j1))];
%     end
%     x_test=[x_test;y(f,:)];
     end
 end
 
% x_training = [xClean(index_training,:) x(index_training,:)];
x_training = [x(index_training,:)];
y_training = y(index_training,:);
% x_testing = [xClean(index_testing,:) x(index_testing,:)];
x_testing = [x(index_testing,:)];
y_testing = y(index_testing,:);
 
 
% A = [index_training-Dim(1)*(fix((index_training-1)./Dim(1))) fix((index_training-1)./Dim(1))+1];
% AA = [index_testing-Dim(1)*(fix((index_testing-1)./Dim(1))) fix((index_testing-1)./Dim(1))+1];
% index_all= [1:Dim(1)*Dim(2)]';
% % AAll = [mod(index_all,Dim(1)) fix(index_all./Dim(1))+1];
% AAll = [index_all-Dim(1)*(fix((index_all-1)./Dim(1))) fix((index_all-1)./Dim(1))+1];
% CordDist = EuDist2(AAll, AAll(1,:)).^2;
% CordDist = CordDist./max(CordDist);
% 
% A = [A CordDist(index_training,1)];
% AA = [AA CordDist(index_testing,1)];
% 
% % index_training = [index_training A xClean(index_training,:)];
% % index_testing = [index_testing AA xClean(index_testing,:)];
% 
% index_training = [index_training A];
% index_testing = [index_testing AA];

 
A = []; AA = [];
U = []; UU = [];

% 
% 
% if radius > 0
% %     xplus = [x;zeros(1,Dim(3))];      %used for filling zeros
%     for i = 1:length(index_training)
%         adjIdx = getAdjacentIndex( Dim(1), Dim(2), index_training(i), radius, 1, 1 );
% %         A = [A; xplus(adjIdx,:)];
%         U = [U; adjIdx];
%         
% %         U = [U; x(adjIdx,:)];
% %         A = [A; exp(-sum(abs(x(adjIdx,:)-repmat(x(index_training(i), :), length(adjIdx), 1))'.^2) / 2)];
% 
% %         A = exp(-sum(abs(xplus(adjIdx,:)-repmat(xplus(index_training(i), :), length(adjIdx), 1))'.^2) / 2);
% %         A(find(A(:)<0.1)) = 0;
% %         U = [U; A*xplus(adjIdx,:)];
%     end
% 
%     for i = 1:length(index_testing)
%         adjIdx = getAdjacentIndex( Dim(1), Dim(2), index_testing(i), radius, 1, 1 );
% %         A = [A; xplus(adjIdx,:)];
%         UU = [UU; adjIdx];
%         
% %         UU = [UU; x(adjIdx,:)];
% %         AA = [AA; exp(-sum(abs(x(adjIdx,:)-repmat(x(index_test(i), :), length(adjIdx), 1))'.^2) / 2
% 
% %         AA = exp(-sum(abs(xplus(adjIdx,:)-repmat(xplus(index_test(i), :), length(adjIdx), 1))'.^2) / 2);
% %         AA(find(AA(:)<0.1)) = 0;
% %         UU = [UU; AA*xplus(adjIdx,:)];
%     end
% else
% %     U = zeros(Dim(1)*Dim(2), 1);
% %     UU = zeros(Dim(1)*Dim(2), 1);
% %     U(index_training,:) = y_training;
% %     UU(index_testing,:) = y_testing;
% %     U = reshape(U, Dim(1),Dim(2));
% %     UU = reshape(UU, Dim(1),Dim(2));
% 
% %     A = [mod(index_training,Dim(1)) fix(index_training./Dim(1))+1];
% %     AA = [mod(index_testing,Dim(1)) fix(index_testing./Dim(1))+1];
% end

 clear x y x_clean;
 
 % ½«±êÇ©ÖÃÎªÁ¬ÐøÀëÉ¢Öµ
if nClass == 2
    y_training(y_training==1) = -1; y_training(y_training==2) = 1;
    y_test(y_test==1) = -1; y_test(y_test==2) = 1;
else
    y_training = smgpTransformLabel( y_training );
    y_testing = smgpTransformLabel( y_testing );
    y_training = smgpTransformLabel( y_training );
    y_testing = smgpTransformLabel( y_testing );
end

fprintf('%s Data Loaded (nSeed=%d; normType=%d; radius=%d).\n', dataSetName,nSeed,normType,radius);

end

