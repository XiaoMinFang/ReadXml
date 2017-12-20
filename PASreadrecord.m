function rec = PASreadrecord(path)

if length(path)<4
    error('unable to determine format: %s',path);
end

if strcmp(path(end-3:end),'.txt')        %判断格式，是否为txt或xml
    rec=PASreadrectxt(path);
else
    rec=VOCreadrecxml(path);
end
