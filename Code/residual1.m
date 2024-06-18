pathV='E:\HBEY\lag&accumulation\KNDVI_Yearly\';   % NDVI路径
pathT='F:\Lag&Accum\T_Yearly\';   % ...
pathP='E:\HBEY\lag&accumulation\Precipitation_Yearly\';   % ...
outpath='E:\HBEY\lag&accumulation\residual\';  % 结果存放路径
[aa,R]=geotiffread([pathV,'KNDVI_2000.tif']); % 任意一个tif文件
info=geotiffinfo([pathV,'KNDVI_2000.tif']);
[m,n]=size(aa);
%% Step1 
ndvisum=zeros(m*n,23); % 34是数据年份
tempsum=zeros(m*n,23);
precsum=zeros(m*n,23);
for year=2000:2022 
    ndvi=importdata(['E:\HBEY\lag&accumulation\KNDVI_Yearly\KNDVI_',int2str(year),'.tif']);
    temp=importdata(['F:\Lag&Accum\T_Yearly\T_',int2str(year),'.tif']) ;
    prec=importdata(['E:\HBEY\lag&accumulation\Precipitation_Yearly\P_',int2str(year),'.tif']); 
    ndvisum(:,year-1999)=reshape(ndvi,m*n,1);
    tempsum(:,year-1999)=reshape(temp,m*n,1);
    precsum(:,year-1999)=reshape(prec,m*n,1);
end
% 多元回归，ndvi=a*temp+b*prec+c
ycsum=zeros(m*n,23)+NaN;  % 预测
ccsum=zeros(m*n,23)+NaN;  % 残差
for i=1:m*n
    prec=precsum(i,:)';
    if min(prec)>=0 % 剔除背景值
        ndvi=ndvisum(i,:)';
        temp=tempsum(i,:)';
        X=[ones(size(ndvi)),temp,prec];
        [b,bint,r,rint,stats]=regress(ndvi,X);
        yc=b(1)+b(2)*temp+b(3)*prec;
        cc=ndvi-yc;
        yc=yc'; 
        cc=cc';
        ycsum(i,:)=yc;
        ccsum(i,:)=cc;
    end
end
for year=2000:2022
    yc=ycsum(:,year-1999);
    yc=reshape(yc,m,n);
    outname1=strcat(outpath,int2str(year),'KNDVI_prd.tif');
    geotiffwrite(outname1,yc,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
    cc=ccsum(:,year-1999);
    cc=reshape(cc,m,n);
    outname2=strcat(outpath,int2str(year),'KNDVI_rsd.tif');
    geotiffwrite(outname2,cc,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
end


