function [img, gt] = get_data(DataSetName)
    % �Ľ������Ӧ�����İ��box�˲���
    switch DataSetName
        case 'Indianpines'
            load('./dataset/Indian_pines_corrected.mat');
            load('./dataset/Indian_pines_gt.mat');
             img = indian_pines_corrected;gt = double(indian_pines_gt);
        case 'KSC'      
            load('./dataset/KSC.mat');
            load('./dataset/KSC_gt.mat');
            img = KSC; gt = double(KSC_gt);
        case 'Salinas'    
            load('./dataset/Salinas_corrected.mat');
            load('./dataset/Salinas_gt.mat');
            img = salinas_corrected; gt = double(salinas_gt);
        case 'SalinasA' 
            load('./dataset/SalinasA_corrected.mat');load('./dataset/SalinasA_gt.mat');
            img = salinasA_corrected; gt = double(salinasA_gt);
        case 'Pavia' 
         load('./dataset/Pavia.mat');load('./dataset/Pavia_gt.mat');
            img = pavia; gt = double(pavia_gt);
        case 'PaviaU' 
            load('./dataset/PaviaU.mat');
            load('./dataset/PaviaU_gt.mat');
            img = paviaU; gt = double(paviaU_gt);
        case 'Botswana'
            load('./dataset/Botswana.mat');load('./dataset/Botswana_gt.mat');
            img = Botswana; gt = double(Botswana_gt);
        case 'Urban4'
            load('./dataset/Urban_R162.mat');load('./dataset/end4_groundTruth.mat');
            Urban = reshape(Y', 307,307,162); [uMax, Urban_gt] =max(A); Urban_gt = reshape(Urban_gt, 307,307);
            Urban_gt(307, 307) = 0;             %to be compatible  with  nClass = size(ind,1)-1; 
            img = Urban; gt = double(Urban_gt);
        case 'Urban5'
            load('./dataset/Urban_R162.mat');load('./dataset/end5_groundTruth.mat');
            Urban = reshape(Y', 307,307,162); [uMax, Urban_gt] =max(A); Urban_gt = reshape(Urban_gt, 307,307);
            Urban_gt(307, 307) = 0;             %to be compatible  with  nClass = size(ind,1)-1; 
            img = Urban; gt = double(Urban_gt);
        case 'Urban6'
            load('./dataset/Urban_R162.mat');load('./dataset/end6_groundTruth.mat');
            Urban = reshape(Y', 307,307,162); [uMax, Urban_gt] =max(A); Urban_gt = reshape(Urban_gt, 307,307);
            Urban_gt(307, 307) = 0;             %to be compatible  with  nClass = size(ind,1)-1; 
            img = Urban; gt = double(Urban_gt);
        case 'Indianpines5' 
            load('./dataset/Indian_pines_5class.mat');
    %        img = indian_pines_corrected; gt = double(indian_pines_gt);
        case 'Earthquake'
            addpath('E:/History Matching/EarthquakeData');
            load('well_corrected.mat','well_corrected');load('well_gt.mat','well_gt');
            img = well_corrected;y = well_gt;
            clear well_corrected well_gt;        
        otherwise
            error('Unknown data set requested.');
    end
end