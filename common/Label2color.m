function classif=Label2color(label,data_name,file_name, showlabel)

if ~exist('showlabel','var'),                   showlabel = 0;  end

[w h]=size(label);

im=zeros(w,h,3);

switch lower(data_name)
    
    case {'paviau'}
        map=[192 192 192;0 255 0;0 255 255;0 128 0; 255 0 255;165 82 41;128 0 128;255 0 0;255 255 0];
        labelname={'Asphalt','Meadows','Gravel','Trees','Painted metal sheets','Bare Soil','Bitumen','Self-Blocking Bricks','Shadows'};
        r = 3; c = 3;  
        for i=1:w
            for j=1:h
                switch(label(i,j))
                    case(1)
                        im(i,j,:)=uint8(map(1,:));
                    case(2)
                        im(i,j,:)=uint8(map(2,:));
                    case(3)
                        im(i,j,:)=uint8(map(3,:));
                    case(4)
                        im(i,j,:)=uint8(map(4,:));
                    case(5)
                        im(i,j,:)=uint8(map(5,:));
                    case(6)
                        im(i,j,:)=uint8(map(6,:));
                    case(7)
                        im(i,j,:)=uint8(map(7,:));
                    case(8)
                        im(i,j,:)=uint8(map(8,:));
                    case(9)
                        im(i,j,:)=uint8(map(9,:));
                end
            end
        end
        
    case 'pavia'
        map=[0 0 255;0 128 0;0 255 0;255 0 0;142 71 2;192 192 192;0 255 255;246 110 0; 255 255 0];
        labelname={'Water','Trees','Asphalt','Self-Blocking Bricks','Bitumen','Tiles','Shadows','Meadows','Bare Soil'};
        r = 3; c = 3;  
        for i=1:w
            for j=1:h
                switch(label(i,j))
                    case(1)
                        im(i,j,:)=uint8(map(1,:));
                    case(2)
                        im(i,j,:)=uint8(map(2,:));
                    case(3)
                        im(i,j,:)=uint8(map(3,:));
                    case(4)
                        im(i,j,:)=uint8(map(4,:));
                    case(5)
                        im(i,j,:)=uint8(map(5,:));
                    case(6)
                        im(i,j,:)=uint8(map(6,:));
                    case(7)
                        im(i,j,:)=uint8(map(7,:));
                    case(8)
                        im(i,j,:)=uint8(map(8,:));
                    case(9)
                        im(i,j,:)=uint8(map(9,:));
                end
            end
        end
        
    case 'indianpines'
%         map=[0 0 255;255 100 0;0 255 134;150 70 150; 100 150 255;60 90 114;255 255 125;255 0 255;100 0 255;1 170 255;0 255 0;175 175 82;100 190 56;140 67 46;115 255 172;255 255 0];
            map=[140 67 46;0 0 255;255 100 0;0 255 123;164 75 155;101 174 255;118 254 172; 60 91 112;255,255,0;255 255 125;255 0 255;100 0 255;0 172 254;0 255 0;171 175 80;101 193 60];
         labelname = {'Alfalfa','Corn-notill','Corn-mintill','Corn','Grass-pasture','Grass-trees','Grass-pasture-mowed',...
                'Hay-windrowed','Oats','Soybean-notill','Soybean-mintill','Soybean-clean','Wheat','Woods','Buildings-Grass-Trees-Drives','Stone-Steel-Towers'};
         r = 4; c = 4;  
         xrange = [140:258]; yrange=[14:522];
         for i=1:w
            for j=1:h
                switch(label(i,j))
                    case(1)
                        im(i,j,:)=uint8(map(1,:));
                    case(2)
                        im(i,j,:)=uint8(map(2,:));
                    case(3)
                        im(i,j,:)=uint8(map(3,:));
                    case(4)
                        im(i,j,:)=uint8(map(4,:));
                    case(5)
                        im(i,j,:)=uint8(map(5,:));
                    case(6)
                        im(i,j,:)=uint8(map(6,:));
                    case(7)
                        im(i,j,:)=uint8(map(7,:));
                    case(8)
                        im(i,j,:)=uint8(map(8,:));
                    case(9)
                        im(i,j,:)=uint8(map(9,:));
                    case(10)
                        im(i,j,:)=uint8(map(10,:));
                    case(11)
                        im(i,j,:)=uint8(map(11,:));
                    case(12)
                        im(i,j,:)=uint8(map(12,:));
                    case(13)
                        im(i,j,:)=uint8(map(13,:));
                    case(14)
                        im(i,j,:)=uint8(map(14,:));   
                    case(15)
                        im(i,j,:)=uint8(map(15,:));   
                    case(16)
                        im(i,j,:)=uint8(map(16,:));   
                end
            end
        end    
        case 'salinas'
%         map=[0 0 255;255 100 0;0 255 134;150 70 150; 100 150 255;60 90 114;255 255 125;255 0 255;100 0 255;1 170 255;0 255 0;175 175 82;100 190 56;140 67 46;115 255 172;255 255 0];
            map=[140 67 46;0 0 255;255 100 0;0 255 123;164 75 155;101 174 255;118 254 172; 60 91 112;255,255,0;255 255 125;255 0 255;100 0 255;0 172 254;0 255 0;171 175 80;101 193 60];
        labelname={'Brocoli-green-weeds-1','Brocoli-green-weeds-2','Fallow','Fallow-rough-plow','Fallow-smooth','Stubble','Celery','Grapes-untrained','Soil-vinyard-develop',...
                    'Corn-senesced-green-weeds','Lettuce-romaine-4wk','Lettuce-romaine-5wk','Lettuce-romaine-6wk','Lettuce-romaine-7wk','Vinyard-untrained','Vinyard-vertical-trellis'};r = 4; c = 4;  
        for i=1:w
            for j=1:h
                switch(label(i,j))
                    case(1)
                        im(i,j,:)=uint8(map(1,:));
                    case(2)
                        im(i,j,:)=uint8(map(2,:));
                    case(3)
                        im(i,j,:)=uint8(map(3,:));
                    case(4)
                        im(i,j,:)=uint8(map(4,:));
                    case(5)
                        im(i,j,:)=uint8(map(5,:));
                    case(6)
                        im(i,j,:)=uint8(map(6,:));
                    case(7)
                        im(i,j,:)=uint8(map(7,:));
                    case(8)
                        im(i,j,:)=uint8(map(8,:));
                    case(9)
                        im(i,j,:)=uint8(map(9,:));
                    case(10)
                        im(i,j,:)=uint8(map(10,:));
                    case(11)
                        im(i,j,:)=uint8(map(11,:));
                    case(12)
                        im(i,j,:)=uint8(map(12,:));
                    case(13)
                        im(i,j,:)=uint8(map(13,:));
                    case(14)
                        im(i,j,:)=uint8(map(14,:));   
                    case(15)
                        im(i,j,:)=uint8(map(15,:));   
                    case(16)
                        im(i,j,:)=uint8(map(16,:));   
                end
            end
        end
        case 'ksc'
%         map=[0 0 255;255 100 0;0 255 134;150 70 150; 100 150 255;60 90 114;255 255 125;255 0 255;100 0 255;1 170 255;0 255 0;175 175 82;100 190 56;140 67 46;115 255 172;255 255 0];
            map=[0 0 255;255 100 0;0 255 123;164 75 155;101 174 255;118 254 172; 60 91 112;255,255,0;255 255 125;255 0 255;100 0 255;0 172 254;0 255 0];
        r = 3; c = 5; 
        for i=1:w
            for j=1:h
                switch(label(i,j))
                    case(1)
                        im(i,j,:)=uint8(map(1,:));
                    case(2)
                        im(i,j,:)=uint8(map(2,:));
                    case(3)
                        im(i,j,:)=uint8(map(3,:));
                    case(4)
                        im(i,j,:)=uint8(map(4,:));
                    case(5)
                        im(i,j,:)=uint8(map(5,:));
                    case(6)
                        im(i,j,:)=uint8(map(6,:));
                    case(7)
                        im(i,j,:)=uint8(map(7,:));
                    case(8)
                        im(i,j,:)=uint8(map(8,:));
                    case(9)
                        im(i,j,:)=uint8(map(9,:));
                    case(10)
                        im(i,j,:)=uint8(map(10,:));
                    case(11)
                        im(i,j,:)=uint8(map(11,:));
                    case(12)
                        im(i,j,:)=uint8(map(12,:));
                    case(13)
                        im(i,j,:)=uint8(map(13,:));
                end
            end
        end
        case 'botswana'
%         map=[0 0 255;255 100 0;0 255 134;150 70 150; 100 150 255;60 90 114;255 255 125;255 0 255;100 0 255;1 170 255;0 255 0;175 175 82;100 190 56;140 67 46;115 255 172;255 255 0];
            map=[140 67 46;0 0 255;255 100 0;0 255 123;164 75 155;101 174 255;118 254 172; 60 91 112;255,255,0;255 255 125;255 0 255;100 0 255;0 172 254;0 255 0];
        r = 3; c = 5;  
        for i=1:w
            for j=1:h
                switch(label(i,j))
                    case(1)
                        im(i,j,:)=uint8(map(1,:));
                    case(2)
                        im(i,j,:)=uint8(map(2,:));
                    case(3)
                        im(i,j,:)=uint8(map(3,:));
                    case(4)
                        im(i,j,:)=uint8(map(4,:));
                    case(5)
                        im(i,j,:)=uint8(map(5,:));
                    case(6)
                        im(i,j,:)=uint8(map(6,:));
                    case(7)
                        im(i,j,:)=uint8(map(7,:));
                    case(8)
                        im(i,j,:)=uint8(map(8,:));
                    case(9)
                        im(i,j,:)=uint8(map(9,:));
                    case(10)
                        im(i,j,:)=uint8(map(10,:));
                    case(11)
                        im(i,j,:)=uint8(map(11,:));
                    case(12)
                        im(i,j,:)=uint8(map(12,:));
                    case(13)
                        im(i,j,:)=uint8(map(13,:));
                    case(14)
                        im(i,j,:)=uint8(map(14,:));
                end
            end
        end
        case 'dc'
        map=[204 102 102;153 51 0;204 153 0;0 255 0; 0 102 0;0 51 255;153 153 153];
        r = 2; c = 4; 
        for i=1:w
            for j=1:h
                switch(label(i,j))
                    case(1)
                        im(i,j,:)=uint8(map(1,:));
                    case(2)
                        im(i,j,:)=uint8(map(2,:));
                    case(3)
                        im(i,j,:)=uint8(map(3,:));
                    case(4)
                        im(i,j,:)=uint8(map(4,:));
                    case(5)
                        im(i,j,:)=uint8(map(5,:));
                    case(6)
                        im(i,j,:)=uint8(map(6,:));
                    case(7)
                        im(i,j,:)=uint8(map(7,:));
                end
            end
        end
end

if ~exist('file_name','var')
    file_name = sprintf('%s.png',data_name);
else
    file_name = [file_name '.png'];
end

% name=sprintf('%s.tif',data_name);
im=uint8(im);
classif=uint8(zeros(w,h,3));
classif(:,:,1)=im(:,:,1);
classif(:,:,2)=im(:,:,2);
classif(:,:,3)=im(:,:,3);
figure(10);
imshow(classif);
% imwrite(classif,file_name);

if showlabel && exist('labelname', 'var')
    map = map./255;
    
%     t = 1; w = 22; h = 5;
%     rectangle( 'Position', [0,0,w*c,h*r]); hold on;
%     for y= r:-1:1
%         for x = 1:c    
%             rectangle( 'Position', [w*(x-1),h*(y-1),w,h], 'FaceColor', map(t,:));  % pos??????
%             text(w*(x-1)+1,h*(y-1)+2.5, labelname{t},'FontSize',8,'Color','k');% 100,100?????
%             t = t+1;
%             hold on;
%         end
%     end
    
    nLabel = size(map,1);
    ystat = tabulate(label(:));
    ystat(1,:) = [];
    t = 1; w = 250; h = 120;
    rectangle( 'Position', [0,0,w*6,(h+10)*nLabel], 'FaceColor', 'white', 'LineStyle', 'none'); hold on;
    rectangle( 'Position', [150,(h+30)*(nLabel+1),w*2,h], 'FaceColor', 'white', 'LineStyle', 'none'); hold on;
    for y= nLabel:-1:1
            text(1,(h+30)*(y)+60, num2str(t),'FontSize',12,'Color','k');% 100,100?????
            rectangle( 'Position', [150,(h+30)*(y),w,h], 'FaceColor', map(t,:));  % pos??????
            text(150+w+20,(h+30)*(y)+60, [labelname{t} '(' num2str(ystat(t,2)) ')'],'FontSize',12,'Color','k');% 100,100?????
            t = t+1;
            hold on;
    end
%     xlim([0,500]);
    axis equal;
    axis off;
    set(gcf,'color','white');


    F = getframe;
%     cdata =F.cdata; cdata = cdata(xrange,yrange,:);F.cdata = cdata;
    [X,map] = frame2im(F);
    file_name = sprintf('%s_LabelBarV.png',data_name);
    imwrite(X,file_name);
end

end