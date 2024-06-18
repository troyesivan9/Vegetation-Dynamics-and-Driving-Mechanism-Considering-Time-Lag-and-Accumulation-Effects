%% This code is origional, please do not copy and modify without my authorization!
%% Author: Liu X et.al 
%% Contact us : liux663@mail2.sysu.edu.cn 

[a,R]=geotiffread('E:\HBEY\DatainPaper\Drivers\KNDVI\kndvi-2000.tif'); 
info=geotiffinfo('E:\HBEY\DatainPaper\Drivers\KNDVI\kndvi-2000.tif');
[m,n]=size(a);
cd=23;  
datasum=zeros(m*n,cd)+NaN; 
k=1;
for year=2000:2022
    filename=['E:\HBEY\DatainPaper\Drivers\KNDVI\kndvi-',int2str(year),'.tif'];
    data=importdata(filename);
    data=reshape(data,m*n,1);
    datasum(:,k)=data;
    k=k+1;
end
result=zeros(m,n)+NaN;
for i=1:size(datasum,1)
    data=datasum(i,:);
    if min(data)>-19
        valuesum=[];
        for k1=2:cd
            for k2=1:(k1-1)
                cz=data(k1)-data(k2);
                jl=k1-k2;
                value=cz./jl;
                valuesum=[valuesum;value];
            end
        end
        value=median(valuesum);
        result(i)=value;
    end
end
filename='E:\HBEY\DatainPaper\DriverTrend\KNDVI_SenTry.tif';
geotiffwrite(filename,result,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag)
