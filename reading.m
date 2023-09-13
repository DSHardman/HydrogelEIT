clear;
clc;

device = serialport("COM6",115200);
data = readline(device);
[X] = str2num(data);

for i=1:10
    data = readline(device);
    [X] = str2num(data);
end

asd=X;

tic
for i=1:1000
    data = readline(device);
    [Y(i,:)] = str2num(data);
      plot((Y-asd)./std(asd))
    tim(i)=toc;
end

%[A,n,errmsg] = sscanf(data,'%f');
