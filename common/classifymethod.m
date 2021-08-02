function [ correctRate,retYYSvm,optC,optG] = classifymethod(train_x,train_y,test_x,test_y,classfy_options )
%UNTITLED �˴���ʾ�йش˺����ժҪ
%   �˴���ʾ��ϸ˵��
addpath('./Tools');
if ~isfield(classfy_options,'method')
    error('���������');
end
switch upper(classfy_options.method)
    case 'KNN'
        knn_k = classfy_options.knn_k;
        distancekey = classfy_options.distancekey;
        distancevalue = classfy_options.distancevalue;
        mdl =ClassificationKNN.fit(train_x,train_y,distancekey,distancevalue,'NumNeighbors',knn_k); 
        classifyresult = predict(mdl,test_x);
        correctRate=length(find(classifyresult-test_y==0))/length(test_y);
        optC=0;
        optG=0;
    case 'SVM'
        addpath('./svm');
        [accSvm, retYYSvm, optC, optG] = svmc(train_x, train_y, test_x, test_y, 0, 0, 2, 1);
        correctRate = accSvm;

end


end

