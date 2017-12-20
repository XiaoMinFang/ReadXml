function rec = VOCreadxml(path)

if length(path)>5&&strcmp(path(1:5),'http:') 
    xml=urlread(path)';                  %urlread函数可以读取网页
else
    f=fopen(path,'r');
    xml=fread(f,'*char')';
    fclose(f);
end
rec=VOCxml2struct(xml);
