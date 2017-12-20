function [ dest ] = drawRect( src, pt, lineSize, color )
%��飺
% %��ͼ��������ɫ�Ŀ�ͼ����������ǻҶ�ͼ����ת��Ϊ��ɫͼ���ٻ���ͼ
% ͼ�����
% ����������  ��  y
% ����������  ��  x
%----------------------------------------------------------------------
%���룺
% src��        ԭʼͼ�񣬿���Ϊ�Ҷ�ͼ����Ϊ��ɫͼ
% pt��         [xmin, xmax, ymin,ymax]

% lineSize�� �ߵĿ��
% color��     �ߵ���ɫ      [r,  g,  b] 
%----------------------------------------------------------------------
%�����
% dest��           �����˵�ͼ��
%----------------------------------------------------------------------

%flag=1: ��ȱ�ڵĿ�
%flag=2: ��ȱ�ڵĿ�
flag = 2;


%�ж������������
if nargin < 4
    color = [255 255 0];
end

if nargin < 3
    lineSize = 1;
end

if nargin < 2
    disp('����������� !!!');
    return;
end





%�жϿ�ı߽�����
[yA, xA, z] = size(src);
x1 = pt(1);
y1 = pt(2);
wx = pt(3) - pt(1);
wy = pt(4) - pt(2);
if  x1 < lineSize 
    x1 = lineSize;
end
if y1 < lineSize
    y1 = lineSize;
end
if wx > xA-lineSize
    wx =  xA - lineSize;
end
if wy > yA-lineSize
    wy = yA-lineSize;
end

%����ǵ�ͨ���ĻҶ�ͼ��ת��3ͨ����ͼ��
if 1==z
    dest(:, : ,1) = src;
    dest(:, : ,2) = src;
    dest(:, : ,3) = src;
else
    dest = src;
end

%��ʼ����ͼ
for c = 1 : 3                 %3��ͨ����r��g��b�ֱ�
    for dl = 1 : lineSize   %�ߵĿ�ȣ���������������չ��
        d = dl - 1;
        if  1==flag %��ȱ�ڵĿ�
            dest(  y1-d ,x1:(x1+wx) ,  c  ) =  color(c); %�Ϸ�����
            dest(  y1+wy+d ,x1:(x1+wx) , c  ) =  color(c); %�·�����
            dest(  y1:(y1+wy) , x1-d ,           c  ) =  color(c); %������
            dest(  y1:(y1+wy) , x1+wx+d ,    c  ) =  color(c); %������
        elseif 2==flag %��ȱ�ڵĿ�
            dest(  y1-d ,(x1-d):(x1+wx+d) ,  c  ) =  color(c); %�Ϸ�����
            dest(  y1+wy+d ,(x1-d):(x1+wx+d) ,  c  ) =  color(c); %�·�����
            dest(  (y1-d):(y1+wy+d) , x1-d ,           c  ) =  color(c); %������
            dest(  (y1-d):(y1+wy+d) , x1+wx+d ,    c  ) =  color(c); %������
        end
    end    
end %��ѭ��β


end %����β