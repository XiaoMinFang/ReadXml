function rec = VOCreadrecxml(path)

x=VOCreadxml(path);
x=x.annotation;       %注释；注解；释文

rec.filename=x.filename;

rec.size.width=str2double(x.size.width);
rec.size.height=str2double(x.size.height);
rec.size.depth=str2double(x.size.depth);
sf=isfield(x,'segmented');
if sf
    rec.segmented=strcmp(x.segmented,'1');
else
    rec.segmented=0;
end

rec.imgsize=str2double({x.size.width x.size.height x.size.depth});

%  VBD Shoulder
% rec.flag = 1;
% f_object = isfield(x.object, 'Shoulder');
% if f_object == 1
%     len = length(x.object.Shoulder);
%     for i = 1:len
%         object = x.object.Shoulder(i);
%         rec.objects(i).bbox = str2double({object.bndbox.xmin object.bndbox.ymin object.bndbox.xmax object.bndbox.ymax});
%     end
% else
%     rec.flag = 0;
% end
%  VBD Shoulder

%%  VBD Wnd
% rec.flag = 1;
% f_object = isfield(x.object, 'Wnd');
% if f_object == 1
%     len = length(x.object.Wnd);
%     for i = 1:len
%         object = x.object.Wnd(i);
%         rec.objects(i).bbox = str2double({object.bndbox.xmin object.bndbox.ymin object.bndbox.xmax object.bndbox.ymax});
%     end
% else
%     rec.flag = 0;
% end
%%  VBD Wnd

%% IPD
% rec.flag = 1;
% % f_head = isfield(x.object,'whole_body');
% f_whole_body = isfield(x.object, 'whole_body');
% 
% if f_whole_body == 1 %&& head == 1
%     %len = min(length(x.object.head), length(x.object.shoulder));
%     len = length(x.object.whole_body);
%     for i = 1:len
%         head = x.object.whole_body(i);
%         rec.objects(i).bbox = str2double({head.bndbox.xmin head.bndbox.ymin head.bndbox.xmax head.bndbox.ymax});
%         rec.objects(i).Face = head.Face;
%     end
% else
%     rec.flag = 0;
% end
%%  IPD
% 头肩
% front = 'Front';  % Front             Back            RSide             LSide                
% rec.flag = 1;
% f_head = isfield(x.object, 'Head');
% if f_head == 1
%     head = x.object.Head; 
%     n_head = length(head);
%     for i = 1:n_head
%         is_face = strcmp(head(i).Face,front);
%         if is_face                   %判断是否为正面
%             rec.head(i) = head(i);
%         else
%             rec.flag = 0;
%         end
%     end
% else
%     rec.flag = 0;
% end


% opa
% front = 'All';  % Front             Back            RSide             LSide                
% rec.flag = 1;
% whole = isfield(x.object, 'Whole');
% if whole == 1
%     face = x.object.Whole; 
%     n_face = length(face);
%     for i = 1:n_face
%         is_face = strcmp(face(i).Face,front);
%         if is_face                   %判断是否为正面
%             rec.head(i) = face(i);
%         else
%             rec.flag = 0;
%         end
%     end
% else
%     rec.flag = 0;
% end


% %  BSC
% front = 'Front';
% rec.flag = 1;
% f_head = isfield(x.object, 'Head');
% if f_head == 1
%     head = x.object.Head; 
%     n_head = length(head);
%     for i = 1:n_head
%         is_face = strcmp(head(i).Face,front);
%         if is_face                   %判断是否为正面
%             rec.head(i) = head(i);
%         else
%             rec.flag = 0;
%         end
%     end
% else
%     rec.flag = 0;
% end
%  BSC

% %%  PED
% rec.flag = 1;
% f_head = isfield(x.object, 'Whole');
% if f_head == 1
%     Whole = x.object.Whole;
%     for i = 1:length(Whole)
%         rec.Whole(i) = Whole(i);
%     end
% else
%     rec.flag = 0;
% end
%%PED

%%  VTS
% rec.flag = 1;
% % f_vts = isfield(x.object,'name');
% f_shoulder = isfield(x.object, 'whole_body');
% 
% if f_shoulder == 1
%     len = length(x.object.whole_body);
%     for i = 1:len
%         VTS = x.object.whole_body(i);
%         rec.objects(i).bbox = str2double({VTS.bndbox.xmin VTS.bndbox.ymin VTS.bndbox.xmax VTS.bndbox.ymax});
%         rec.objects(i).Face = VTS.Face;
%     end
% else
%     rec.flag = 0;
% end
%%  ipv
front = 'Front';  % Front             Back            RSide             LSide                
rec.mask_flag = 1;
rec.species_flag = 1;
is_mask = isfield(x.object, 'Mask');
is_species = isfield(x.object,'Species');
if is_mask == 1  
    mask = x.object.Mask;  
    n_mask = length(mask);
    for i = 1:n_mask
        rec.mask(i) = mask(i);
    end 
else
    rec.mask_flag = 0;
end
if is_species == 1
    species = x.object.Species;
    n_species = length(species);
    for j = 1:n_species
       rec.species(j) = species(j); 
    end
else
    rec.species_flag = 0;
end



function p = xmlobjtopas(o)

p.class=o.name;

if isfield(o,'pose')
    if strcmp(o.pose,'Unspecified')
        p.view='';
    else
        p.view=o.pose;
    end
else
    p.view='';
end

if isfield(o,'truncated')
    p.truncated=strcmp(o.truncated,'1');
else
    p.truncated=false;
end

if isfield(o,'occluded')
    p.occluded=strcmp(o.occluded,'1');
else
    p.occluded=false;
end

if isfield(o,'difficult')
    p.difficult=strcmp(o.difficult,'1');
else
    p.difficult=false;
end

p.label=['PAS' p.class p.view];
if p.truncated
    p.label=[p.label 'Trunc'];
end
if p.occluded
    p.label=[p.label 'Occ'];
end
if p.difficult
    p.label=[p.label 'Diff'];
end

p.orglabel=p.label;

p.bbox=str2double({o.bndbox.xmin o.bndbox.ymin o.bndbox.xmax o.bndbox.ymax});

p.bndbox.xmin=str2double(o.bndbox.xmin);
p.bndbox.ymin=str2double(o.bndbox.ymin);
p.bndbox.xmax=str2double(o.bndbox.xmax);
p.bndbox.ymax=str2double(o.bndbox.ymax);

if isfield(o,'polygon')
    warning('polygon unimplemented');
    p.polygon=[];
else
    p.polygon=[];
end

if isfield(o,'mask')
    warning('mask unimplemented');
    p.mask=[];
else
    p.mask=[];
end

if isfield(o,'part')&&~isempty(o.part)
    p.hasparts=true;
    for i=1:length(o.part)
        p.part(i)=xmlobjtopas(o.part(i));
    end
else
    p.hasparts=false;
    p.part=[];
end

if isfield(o,'actions')
    p.hasactions=true;
    fn=fieldnames(o.actions);
    for i=1:numel(fn)
        p.actions.(fn{i})=strcmp(o.actions.(fn{i}),'1');
    end
else
    p.hasactions=false;
    p.actions=[];
end
