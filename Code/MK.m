%% This code is origional, please do not copy and modify without my authorization!
%% Author: Liu X et.al 
%% Contact us : liux663@mail2.sysu.edu.cn 

clear
[a,R]=geotiffread('C:\Users\Troye Sivan\Desktop\ClimateData\T2000-2021\2002.tif'); 
info=geotiffinfo('C:\Users\Troye Sivan\Desktop\ClimateData\T2000-2021\2002.tif');
[m,n]=size(a);
cd=21;       
datasum=zeros(m*n,cd)+NaN; 
p=1;
for year=2000:2020      
     filename=['C:\Users\Troye Sivan\Desktop\ClimateData\T2000-2021\',int2str(year),'.tif'];
    data=importdata(filename);
    data=reshape(data,m*n,1);
    datasum(:,p)=data;         
    p=p+1;
end
sresult=zeros(m,n)+NaN;

for i=1:size(datasum,1)        
    data=datasum(i,:);
    if min(data)>-19999      
        sgnsum=[];  
        for k=2:cd
            for j=1:(k-1)
                sgn=data(k)-data(j);
                if sgn>0
                    sgn=1;
                else
                    if sgn<0
                        sgn=-1;
                    else
                        sgn=0;
                    end
                end
                sgnsum=[sgnsum;sgn];
            end
        end  
        add=sum(sgnsum);
        sresult(i)=add; 
    end
end
vars=cd*(cd-1)*(2*cd+5)/18;
zc=zeros(m,n)+NaN;
sy=sresult==0;
zc(sy)=0;
sy=find(sresult>0);
zc(sy)=(sresult(sy)-1)./sqrt(vars);
sy=find(sresult<0);
zc(sy)=(sresult(sy)+1)./sqrt(vars);
geotiffwrite('C:\Users\Troye Sivan\Desktop\NDVI\SenMK\MK.tif',zc,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag); 
