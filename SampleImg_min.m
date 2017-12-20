% function dst_img = SampleImg_min(src_img,template,object_postion,scalar,shake)
% %实现根据不同的要求（缩放尺寸、上下左右的抖动）裁剪图像
% %  dstImg ：输出图像的位置和宽高
% %  src_img :输入图像
% %  template : [w,h] 希望裁剪的尺寸
% %  object_postion ：[x,y,w,h]  目标在源图像中的位置(x坐标、y坐标、宽、高)；
% %  scalar ：缩放尺度
% %  shake ：[up，down，left,right]上下左右方向的抖动数值
% 
% 
% % [image_w,image_h] = size(src_img); 
% 
% x = object_postion(:,1);
% y = object_postion(:,2);
% object_w = object_postion(:,3);
% object_h = object_postion(:,4);
% 
% template_w = template(:,1);
% template_h = template(:,2);
% 
% template_ratio = template_w / template_h;
% object_ratio =  object_w / object_h;
% if(object_ratio > template_ratio)  %%%扩展高
%     temp_h = object_w/template_ratio;
%     y =int32( y - (temp_h - object_h)/2 );
%     object_h =int32(y + object_h + (temp_h - object_h)/2 );
% elseif(object_ratio < template_ratio)                              %%扩展宽
%         temp_w = object_h*template_ratio;
%         x =int32( x - (temp_w - object_w)/2 );
%         object_w = int32(x + object_w + (temp_w - object_w)/2);
% else
%     x = int32(x);
%     y = int32(y);
%     object_w = int32(object_w);
%     object_h = int32(object_h);
% end
% 
% %%%计算裁剪的边框位置(包含上下方向的抖动)
% left = shake(3);
% right = shake(4);
% up = shake(1);
% down = shake(2);
% 
% xmin = x ;
% ymin = y ;
% 
% 
% % img = imcrop(src_img,[xmin,ymin,object_w,object_h]);
% % img = imresize(img,[template_h,template_w]);
% 
% % img = imresize(img,scalar);
% 
% % xmin = int32((template_w * scalar)/2 - template_w/2 - left + right);
% % ymin = int32((template_h * scalar)/2 - template_h/2 - up + down);
% 
% xmin = int32(xmin - left + right);
% ymin = int32(ymin - up + down);
% if(xmin<0 || ymin<0)
%     xmin = 0;
%     ymin = 0;
% end
% 
% dst_img = imcrop(src_img,[xmin,ymin,template_w,template_h]);
% % dst_img = imresize(img,[template_h,template_w]);
% end

function dst_img = SampleImg_min(src_img,template,object_postion,scalar,shake)
%实现根据不同的要求（缩放尺寸、上下左右的抖动）裁剪图像
%  dstImg ：输出图像的位置和宽高
%  src_img :输入图像
%  template : [w,h] 希望裁剪的尺寸
%  object_postion ：[x,y,w,h]  目标在源图像中的位置(x坐标、y坐标、宽、高)；
%  scalar ：缩放尺度
%  shake ：[up，down，left,right]上下左右方向的抖动数值


[h1,w1,c] = size(src_img); 
img = imresize(src_img,scalar);
[h2,w2,c] = size(img);
x_ex = (w2-w1)/2;
y_ex = (h2-h1)/2;

x = object_postion(:,1) + x_ex;
y = object_postion(:,2) + y_ex;
object_w = object_postion(:,3);
object_h = object_postion(:,4);

xmin = x;
ymin = y;
xmax = x+object_w;
ymax = y+object_h;

%%%计算裁剪的边框位置(包含上下方向的抖动)
left = shake(3);
right = shake(4);
up = shake(1);
down = shake(2);

xmin = int32(xmin - left + right);
xmax = int32(xmax - left + right);
ymin = int32(ymin - up + down);
ymax = int32(ymax - up + down);
if(xmin<0)
    xmin = 1;
end
if(ymin<0)
    ymin = 1;
end
if(ymax>h2)
    ymax = h2-1;
end
if(xmax>w2)
    xmax = w2-1;
end
object_w = int32(xmax - xmin);
object_h = int32(ymax - ymin);
% x_ce = xmin + object_w/2;
% y_ce = ymin + object_h/2;
% object_w = object_w * scalar;
% object_h = object_h * scalar;
% xmin = x_ce - object_w/2;
% ymin = y_ce - object_h/2;

dst_img = imcrop(img,[xmin,ymin,object_w,object_h]);
% imshow(dst_img);
% dst_img = imresize(img,scalar);
end
