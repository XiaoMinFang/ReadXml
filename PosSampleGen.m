clc
clear

% posnum = 200000; %3467
% extend = 4;   %每张图片扩展成样本的个数
% template = [56,48];  %样本模板尺寸
% 
% index = 3265;

% txtpath = 'E:\样本采集\IPD_3\IPD_last\ipd_last.txt';
% fp = fopen(txtpath,'r');
% while(~feof(fp))
%     xmlfile = fgetl(fp); 
%     xmlfile
    %%%%%%%读xml------------------------------------------------%%%%
    
listpath = 'E:\IPV\sample\pos2\train\list3.txt' ;
list = fopen(listpath,'r');

while(~feof(list))
% for i = 1:1:400
    
    xml_id = fgetl(list);
    xmlfile = sprintf('E:/IPV/sample/pos2/train/XML/%s.xml',xml_id)
    imgfile = sprintf('E:/IPV/sample/pos2/images2/%s.jpg',xml_id);
%     imgwritefile = sprintf('E:/IPV/sample/IMAGE_201712141140/IMAGE_201712141140/images/%s.jpg',xml_id);
    %
    if (exist(xmlfile,'file'))&&(exist(imgfile,'file'))
        im = imread(imgfile);
        rec = PASreadrecord(xmlfile);
        if rec.species_flag
           species = rec.species;
           n_species = length(rec.species);
           for i = 1:n_species
%              if strcmp(species(i).Face,'Lorry')
                 bbox = species(i).bndbox;
                 pt(1) = str2num(bbox.xmin);
                 pt(2) = str2num(bbox.ymin);
                 pt(3) = str2num(bbox.xmax);
                 pt(4) = str2num(bbox.ymax);                 
                 im = drawRect(im,pt,3,[0 255 255]);
           end
        end
        imshow(im)
%         if rec.mask_flag
%             clsinds = length(rec.mask);
%             for j = 1:clsinds
%                 bbox = rec.mask(j).bndbox;
%                 x1 = str2num(bbox.xmin);
%                 y1 = str2num(bbox.ymin);
%                 x2 = str2num(bbox.xmax);
%                 y2 = str2num(bbox.ymax);
%                 im(y1:y2,x1:x2,1) = 0;
%                 im(y1:y2,x1:x2,2) = 0;
%                 im(y1:y2,x1:x2,3) = 0;
%             end
%         end
%         imwrite(im,imgwritefile);
    end   
    
 
end
fclose('all');

