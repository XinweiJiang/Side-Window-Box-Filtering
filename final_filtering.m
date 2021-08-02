function [] = final_filtering(DataSetName, classifier, train_number, o_p_r, iter)
    addpath('./libsvm-3.24');
    addpath('./common');
    addpath('./filtering');
    addpath('./LASIP_Image_Restoration_DemoBox_v120');

    %--------------------------------------------------------------------------
    % Find capabilities of computer so we can best utilize them.

    % Find if gpu is present
    ngpus=gpuDeviceCount;
    disp([num2str(ngpus) ' GPUs found'])
    if ngpus>0
        lgpu=1;
        disp('GPU found')
        useGPU='yes';
    else
        lgpu=0;
        disp('No GPU found')
        useGPU='no';
    end

    % Find number of cores
    ncores=feature('numCores');
    disp([num2str(ncores) ' cores found'])

    % Find number of cpus
    import java.lang.*;
    r=Runtime.getRuntime;
    ncpus=r.availableProcessors;
    disp([num2str(ncpus) ' cpus found'])

    if ncpus>1
        useParallel='yes';
    else
        useParallel='no';
    end

    [archstr,maxsize,endian]=computer;
    disp([...
        'This is a ' archstr ...
        ' computer that can have up to ' num2str(maxsize) ...
        ' elements in a matlab array and uses ' endian ...
        ' byte ordering.'...
        ])

    % Set up the size of the parallel pool if necessary
    npool=ncores;

    % Opening parallel pool
    CoreNum=npool; %调用的处理器个数
    poolobj = gcp('nocreate');
    if isempty(poolobj)  %之前没有打开
        parpool(CoreNum);
    else  %之前已经打开
        poolsize = poolobj.NumWorkers;
        disp('matlab pool already started');
    end





    %%   Classify options
    classfy_options=[];
    classfy_options.method='SVM';
    % classfy_options.method = 'KNN';
    classfy_options.knn_k = 3;
    classfy_options.distancekey='Distance';
    classfy_options.distancevalue='cosine';
    dim = 30;
    splitOptions=[];
    % splitOptions.nTrEachClass = number;
    % DataSetName = 'Indianpines';  % Indianpines  Salinas  PaviaU
    
    
    
    switch classifier
        case 'box'
            img = get_data(DataSetName);
            img = img./max(img(:));
            switch DataSetName
                case 'Indianpines'
                    data = box(img,6,1);
                case 'Salinas'    
                    data = box(img,10,1);
                case 'PaviaU' 
                    data = box(img,3,1);
            end 
        case 'sw_box'    
            img = get_data(DataSetName);
            img = img./max(img(:));
            switch DataSetName
                case 'Indianpines'
                    if o_p_r == 0
                        data = sw_box(img, 4, 30);
                    elseif o_p_r == 1
                        img = img_pca(img,110);
                        data = sw_box(img, 3, 27); 
                    end
                case 'Salinas' 
                    if o_p_r == 0
                        data = sw_box(img, 5, 30);
                    elseif o_p_r == 1
                        img = img_pca(img,90);
                        data = sw_box(img, 5, 30); 
                    end 
                case 'PaviaU' 
                    if o_p_r == 0
                        data = sw_box(img, 3, 30);
                    elseif o_p_r == 1
                        img = img_pca(img,10);
                        data = sw_box(img, 3, 30); 
                    end
            end 
        case 'adapt_sw_box'    
            img = get_data(DataSetName);
            img = img./max(img(:));
            switch DataSetName
                case 'Indianpines'
                    if o_p_r == 0
                        data = shape_adapt_sw(img, 30);
                        img = img_pca(img,110);
                        data = shape_adapt_sw(img, 5); 
                    end
                case 'Salinas' 
                    if o_p_r == 0
                        data = shape_adapt_sw(img, 30); 
                    elseif o_p_r == 1
                        img = img_pca(img,90);
                        data = shape_adapt_sw(img, 16); 
                    end 
                case 'PaviaU' 
                    if o_p_r == 0
                        data = shape_adapt_sw(img, 30); 
                    elseif o_p_r == 1
                        img = img_pca(img,30);
                        data = shape_adapt_sw(img, 12); 
                    end
            end 
        case 'gabor'
            img = get_data(DataSetName);
            img = padarray(img,[1,1]);
            data = gabor(img);
        case 'emp' 
            switch DataSetName
                case 'Indianpines'
                    load('/mnt/data/yanqin/dataset/EMP_Indianpines.mat');
                case 'Salinas'    
                    load('/mnt/data/yanqin/dataset/EMP_Salinas.mat');
                case 'PaviaU' 
                    load('/mnt/data/yanqin/dataset/EMP_PaviaU.mat');
            end
            data = emp;
        case 'gf'
            img = get_data(DataSetName);
            img = img./max(img(:));
            guide_img = img_pca(img, 1);
            if o_p_r == 1
                img = img_pca(img,140);
            end
            [m,n,c] = size(img);
            data = img;
            data = zeros(m,n,c);
            for i = 1:c
                data(:,:,i) = guidedfilter(guide_img,img(:,:,i),3,0.001);
            end
        case 'pf'
            switch DataSetName
                case 'Indianpines'
                    load('./dataset/PF_Indianpines.mat');
                case 'Salinas'    
                    load('./dataset/PF_Salinas.mat');
                case 'PaviaU' 
                    load('./dataset/PF_PaviaU.mat');
            end
            data = fimg;
        case 'lbp'
                img = get_data(DataSetName);
                img = img./max(img(:));
                if o_p_r == 1
                    img = img_pca(img,140);
                end
                data = img;
                [m,n,c] = size(data);

                r = 21;     %indian 8    salinas 12   paviau 10
                data = padarray(data,[r,r],'replicate');
                lbp_data = zeros(m,n,59);
                mapping = getmapping(8,'u2');
                for i = 1+r:m+r
                    for j = 1+r:n+r
                        lbp_data(i-r,j-r,:) = lbp(data(i-r:i+r,j-r:j+r),2,8,mapping,'h');
                    end
                end
            data = lbp_data;
        case 'bf'
            switch DataSetName
                case 'Indianpines'
                    load('/mnt/data/yanqin/dataset/BF_Indianpines.mat');
                case 'Salinas'    
                    load('/mnt/data/yanqin/dataset/BF_Salinas.mat');
                case 'PaviaU' 
                    load('/mnt/data/yanqin/dataset/BF_PaviaU.mat');
            end
            data = bf_data;
        case 'dtrf' 
            img = get_data(DataSetName);
            img = img./max(img(:));
            sigma_s = 260;
            sigma_r = 0.43;
            data = RF(img_pca(img,dimen), sigma_s, sigma_r,10);
        case 'cf'
            addpath('E:/History Matching/EarthquakeData');
            load('well_corrected.mat','well_corrected');load('well_gt.mat','well_gt');
            img = well_corrected;y = well_gt;
            clear well_corrected well_gt;        
        otherwise
            error('Unknown classifier requested.');
    end


    splitOptions.normType = 1;
    splitOptions.radius = 0;
    DR_options.k = 5;
    result_name = 'all_result.txt';
    fid = fopen(result_name,'a+');
    oa = zeros(1,10);
    aa = zeros(1,10);
    kappa = zeros(1,10);
    my_map = zeros(10,size(data,1),size(data,2));
    for i = 1:size(train_number,2)
        splitOptions.nTrEachClass = train_number(i);

        parfor index=1:10
            [oa(index),aa(index),kappa(index),my_map(index,:,:)] = hsi_classify(index,DataSetName,splitOptions,DR_options,classfy_options,dim,data);
        end
        oa_mean = roundn(mean(oa),-4);
        oa_std = roundn(std(oa),-4);
        aa_mean = roundn(mean(aa),-4);
        aa_std = roundn(std(aa),-4);
        kappa_mean = roundn(mean(kappa),-4);
        kappa_std = roundn(std(kappa),-4);
        fprintf(fid,'%s %s %d      %g ± %g___%g ± %g___%g ± %g\n', DataSetName, classifier,train_number(i),oa_mean*100,oa_std*100,aa_mean*100,aa_std*100,kappa_mean*100,kappa_std*100);
        fprintf('%s %s %d      %g ± %g___%g ± %g___%g ± %g\n', DataSetName, classifier,train_number(i),oa_mean*100,oa_std*100,aa_mean*100,aa_std*100,kappa_mean*100,kappa_std*100);
        [M,I] = min(abs(oa - oa_mean));
        file_name = [DataSetName,'_',classifier,'_',int2str(train_number(i)),'_',mat2str(oa(i))];
        Label2color(reshape(my_map(I,:,:),size(data,1),size(data,2)),DataSetName,file_name);
    end
    fclose(fid);
end