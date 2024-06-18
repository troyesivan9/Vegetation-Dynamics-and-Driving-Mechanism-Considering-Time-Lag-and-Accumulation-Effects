pathV='E:\HBEY\lag&accumulation\KNDVI_Yearly\';   % NDVI路径
outpath='E:\HBEY\lag&accumulation\KNDVI&prt&rsd_Trend\';  % 结果存放路径
[aa,R]=geotiffread([pathV,'KNDVI_2000.tif']); % 任意一个tif文件
info=geotiffinfo([pathV,'KNDVI_2000.tif']);
[m,n]=size(aa);
%% Step2 一元线性回归趋势 
data1=zeros(m*n,23); % 预测
data2=zeros(m*n,23); % 残差
data3=zeros(m*n,23); % 真值
for i=1:23
    filename=strcat('E:\HBEY\lag&accumulation\residual\KDNVI_prd_',int2str(i+1999),'.tif');
    bz=importdata(filename);
    bz=reshape(bz,m*n,1);
    data1(:,i)=bz;  
    filename=strcat('E:\HBEY\lag&accumulation\residual\KNDVI_rsd_',int2str(i+1999),'.tif');
    bz=importdata(filename);
    bz=reshape(bz,m*n,1);
    data2(:,i)=bz;  
    filename=strcat('E:\HBEY\lag&accumulation\KNDVI_Yearly\KNDVI_',int2str(i+1999),'.tif');
    bz=importdata(filename);
    bz=reshape(bz,m*n,1);
    data3(:,i)=bz;  
end
trend1=zeros(m,n);
trend2=zeros(m,n);
trend3=zeros(m,n);
for i=1:length(data1)
    % 预测
    bz=data1(i,:);
    bz=bz';  
    X=[ones(size(bz)) bz];
    X(:,2)=[1:23]';
    [b,bint,r,rint,stats]=regress(bz,X);
    trend1(i)=b(2);
    % 残差
    bz=data2(i,:);
    bz=bz';  
    X=[ones(size(bz)) bz];
    X(:,2)=[1:23]';
    [b,bint,r,rint,stats]=regress(bz,X);
    trend2(i)=b(2);
    % 真值
    bz=data3(i,:);
    bz=bz';  
    X=[ones(size(bz)) bz];
    X(:,2)=[1:23]';
    [b,bint,r,rint,stats]=regress(bz,X);
    trend3(i)=b(2);
end
geotiffwrite([outpath,'ndvi预测趋势.tif'],trend1,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite([outpath,'ndvi残差趋势.tif'],trend2,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite([outpath,'ndvi真值趋势.tif'],trend3,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);

